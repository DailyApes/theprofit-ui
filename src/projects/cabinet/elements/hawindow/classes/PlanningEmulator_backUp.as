package projects.cabinet.elements.hawindow.classes
{
	import mx.utils.ObjectUtil;
	
	import engine.components.DataGridSet;
	import engine.components.DateSelector;
	import engine.core.Core;
	import engine.extended.CheckBox;

	public class PlanningEmulator
	{
		public function PlanningEmulator()
		{
			
		}
		
		public static function init(planningDataProvider:Object, dataGridSet:DataGridSet, dateSelector:DateSelector, plannedsCheckBox:CheckBox):void
		{
			var step:Number = 0;
			var fromTime:Number = 0;
			var toTime:Number = 0;
			var repeats_done:Number = 0;
			var j:Number = 0;
			var done:Boolean;
			
			var date:Date;
			var length:Number;
			
			for (var i:int = 0; i < planningDataProvider.length(); i++)
			{
				var index_id:Number = 0;
				switch(Core.toNumber(planningDataProvider[i]['@periodicity_id']))
				{
					//один раз
					case 1:
					{
						//если не выбрана дата окончания или (запланированная дата больше либо равна дате начала диапазона и запланированная дата меньше либо равна дате окончания)
						if (!dateSelector.toDateField.selectedDate || (planningDataProvider[i]['@date'] >= Core.dateConvert(dateSelector.fromDateField.selectedDate) && planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate)))
						{
							//если выбран чекбокс "запланированные" или запланированная дата меньше текущей и запланированный платеж не подтвержден (или не отменен) 
							if ((plannedsCheckBox.selected || (planningDataProvider[i]['@date'] <= Core.dateConvert(new Date())) && !Core.inList(0, String(planningDataProvider[i]['@index_id']).split(','))))
							{
								addRecord(Core.dateFromString(planningDataProvider[i]['@date']), planningDataProvider[i], index_id);
							}
						}
						break;
					}
						
					//ежедневно
					case 2:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							var weekdaysArray:Array = String(planningDataProvider[i]['@weekdays']).split(',');
							
							while (!done)
							{
								var dateFromString:Date = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if ((plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date()) && Core.toBoolean(weekdaysArray[date.day]))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
																		
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					//еженедельно
					case 3:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = 7 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							
							while (!done)
							{
								dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if (plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date())
								{
									trace("!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(','))", !Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')));
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
									
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					//ежемесячно
					case 4:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = 30 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							
							while (!done)
							{
								dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if (plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date())
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
									
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					//ежеквартально
					case 5:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = 4 * 30 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							
							while (!done)
							{
								dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if (plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date())
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
									
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					//ежегодно
					case 6:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = 365 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							
							while (!done)
							{
								dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if (plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date())
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
									
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					//каждые n дней
					case 7:
					{
						if (!dateSelector.toDateField.selectedDate || planningDataProvider[i]['@date'] <= Core.dateConvert(dateSelector.toDateField.selectedDate))
						{
							step = planningDataProvider[i]['@every_n_days'] * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							repeats_done = 0;
							j = 0;
							done = false;
							
							if (!dateSelector.toDateField.selectedDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDateField.selectedDate.time;
							}
							
							if (dateSelector.fromDateField.selectedDate)
							{
								fromTime = dateSelector.fromDateField.selectedDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000) - Core.dateFromString(planningDataProvider[i]['@date']).time;
							
							while (!done)
							{
								dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.day).time + j);
								
								if (plannedsCheckBox.selected && date.time >= fromTime && date.time <= toTime || date.time >= fromTime && date <= new Date())
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
									
									if (planningDataProvider[i]['@repeats'] > 0)
									{
										repeats_done += 1;
									}
								}
								
								j += step;
								index_id += 1;
								
								if (j >= length || planningDataProvider[i]['@repeats'] > 0 && repeats_done >= planningDataProvider[i]['@repeats'])
								{
									done = true;
								}
							}
						}
						break;
					}
						
					default:
					{
						break;
					}
				}
			}
			
			function addRecord(date:Date, item:Object, index_id:Number):void
			{
				var item:Object = ObjectUtil.clone(item);
				
				item['@planned_id'] = item['@item_id'];
				item['@item_id'] = null;
				item['@periodicity_id'] = null;
				item['@weekdays'] = null;
				item['@every_n_days'] = null;
				item['@repeats'] = null;
				item['@repeats_done'] = null;
				item['@date'] = Core.dateConvert(date);
				item['@index_id'] = index_id;
				
				var message:String;
				if (item['@date'] <= Core.dateConvert(new Date()))
				{
					message = 'awaiting_confirmation';
				}
				else
				{
					message = 'it_planned';
				}
				
				item['@comment'] = Core.translate.to([message]) + (String(item['@note']) !== '' ? ' | ' + item['@note'] : '');
				dataGridSet.dataGrid.dataProvider.addItem(item);
			}
		}
	}
}