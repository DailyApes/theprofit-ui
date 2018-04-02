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
			var dateFromString:Date;
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
						if ((!dateSelector.fromDate || dateSelector.fromDate <= Core.dateFromString(planningDataProvider[i]['@date']))
							&& (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
							&& (plannedsCheckBox.selected || Core.dateFromString(planningDataProvider[i]['@date']) <= Core.today())
							&& !Core.inList(0, String(planningDataProvider[i]['@index_id']).split(',')))
						{
							addRecord(Core.dateFromString(planningDataProvider[i]['@date']), planningDataProvider[i], index_id);
						}
						break;
					}
						
					//ежедневно
					case 2:
					{
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 25 * 60 * 60 * 1000) - fromTime;
							var weekdaysArray:Array = String(planningDataProvider[i]['@weekdays']).split(',');
							
							while (!done)
							{
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date).time + j);
								date = new Date(date.fullYear, date.month, date.date);
								
								if (Core.toBoolean(weekdaysArray[date.day]))
								{
									if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
									{
										if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
										{
											addRecord(date, planningDataProvider[i], index_id);
										}
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
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = 7 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 25 * 60 * 60 * 1000) - fromTime;
							
							while (!done)
							{
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date).time + j);
								date = new Date(date.fullYear, date.month, date.date);
								
								if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
								}
								
								if (planningDataProvider[i]['@repeats'] > 0)
								{
									repeats_done += 1;
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
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = 31 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000 + 60 * 60 * 1000) - fromTime;
							
							while (!done)
							{
								date = new Date(dateFromString.fullYear, dateFromString.month + index_id, dateFromString.date);
								
								if (dateFromString.date !== date.date)
								{
									date = new Date(date.fullYear, date.month, 0);
								}
								
								if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
								}
								
								if (planningDataProvider[i]['@repeats'] > 0)
								{
									repeats_done += 1;
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
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = 3 * 31 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 3 * 31 * 24 * 60 * 60 * 1000 + 60 * 60 * 1000) - fromTime;
							
							while (!done)
							{
								date = new Date(dateFromString.fullYear, dateFromString.month + index_id * 3, dateFromString.date);
								
								if (dateFromString.date !== date.date)
								{
									date = new Date(date.fullYear, date.month, 0);
								}
								
								if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
								}
								
								if (planningDataProvider[i]['@repeats'] > 0)
								{
									repeats_done += 1;
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
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = 366 * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 24 * 60 * 60 * 1000 + 60 * 60 * 1000) - fromTime;
							
							while (!done)
							{
								date = new Date(dateFromString.fullYear + index_id, dateFromString.month, dateFromString.date);
								
								if (dateFromString.date !== date.date)
								{
									date = new Date(date.fullYear, date.month, 0);
								}
								
								if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
								}
								
								if (planningDataProvider[i]['@repeats'] > 0)
								{
									repeats_done += 1;
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
						if (!dateSelector.toDate || dateSelector.toDate >= Core.dateFromString(planningDataProvider[i]['@date']))
						{
							step = planningDataProvider[i]['@every_n_days'] * 24 * 60 * 60 * 1000;
							fromTime = 0;
							toTime = 0;
							
							dateFromString = Core.dateFromString(planningDataProvider[i]['@date']);
							dateFromString = new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date);
							
							repeats_done = 0;
							j = 0;
							done = false;
							
							fromTime = dateFromString.time;
							
							if (!dateSelector.toDate)
							{
								toTime = new Date().time;
							}
							else
							{
								toTime = dateSelector.toDate.time;
							}
							
							length = (toTime + 25 * 60 * 60 * 1000) - fromTime;
							
							while (!done)
							{
								date = new Date(new Date(dateFromString.fullYear, dateFromString.month, dateFromString.date).time + j);
								date = new Date(date.fullYear, date.month, date.date);
								
								if ((plannedsCheckBox.selected && date >= dateSelector.fromDate && date <= dateSelector.toDate || date >= dateSelector.fromDate && date <= new Date()))
								{
									if (!Core.inList(index_id, String(planningDataProvider[i]['@index_id']).split(',')))
									{
										addRecord(date, planningDataProvider[i], index_id);
									}
								}
								
								if (planningDataProvider[i]['@repeats'] > 0)
								{
									repeats_done += 1;
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