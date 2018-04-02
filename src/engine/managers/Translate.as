package engine.managers
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.resources.ResourceBundle;
	
	import spark.components.Group;
	
	import engine.core.Core;

	public class Translate extends Group
	{
		public function Translate():void
		{
			resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler);

			Core.data.locales['addEventListener'](Event.CHANGE, locales_changeHandler);
			Core.data.locales.refresh();
		}
		
		private function resourceManager_changeHandler(event:Event):void
		{
			dispatchEvent(new Event('change'));
		}
		
		private function locales_changeHandler(event:Event):void
		{
			var languageResources:Object = new Object();
			
			for (var i:int = 0; i < Core.data.locales.dataProvider.length(); i++) 
			{
				for (var j:int = 0; j < Core.data.locales.dataProvider[i].attributes().length(); j++) 
				{
					var locale:String = Core.data.locales.dataProvider[i].attributes()[j].name().toString();
					
					if (locale !== 'item_id' && locale !== 'locale')
					{
						var value:String = Core.data.locales.dataProvider[i].attributes()[j].toString();
						
						if (!languageResources[locale])
						{
							languageResources[locale] = new ResourceBundle(locale, "system");
						}
						languageResources[locale].content[Core.data.locales.dataProvider[i].@locale] = value;						
					}
				}
			}
			
			for (var item:Object in languageResources) 
			{
				resourceManager.addResourceBundle(languageResources[item]);
			}
			
			dispatchEvent(new Event('change'));
		}
		
		[Bindable ('change')]
		public function to(array:Array, delimiter:String = ' '):String
		{
			var finishedArray:Array = new Array();
			
			for (var j:int = 0; j < array.length; j++) 
			{
				var itemArray:Array = String(array[j]).split(' ');
				
				for (var k:int = 0; k < itemArray.length; k++) 
				{
					finishedArray.push(itemArray[k]);
				}
			}
			
			var string:String = '';
			
			for (var i:int = 0; i < finishedArray.length; i++) 
			{
				if (finishedArray[i] !== '\n')
				{
					var value:String = resourceManager.getString('system', String(finishedArray[i]).toLowerCase());
					string += value ? value : finishedArray[i];
					
					if (i < finishedArray.length - 1)
					{
						string += delimiter;
					}
				}
				else
				{
					string += '\n';
				}
			}
			
			Core.replaceAll(string, ' \n ', '\n');
			
			return string;
		}
		
		public function columns(dataProvider:Object, columns:String = ''):Object
		{
			if (dataProvider)
			{
				columns = Core.replaceAll(columns, ' ', '');
				var columnsArray:Array = columns.split(',');
				
				if (columns.length > 0)
				{
					var dataProviderLength:Number = dataProvider is ArrayCollection || dataProvider is ArrayList ? dataProvider.length : dataProvider.length(); 
					
					for (var i:int = 0; i < dataProviderLength; i++)
					{
						for (var j:int = 0; j < columnsArray.length; j++)
						{
							dataProvider[i][columnsArray[j]] = Core.translate.to([dataProvider[i][columnsArray[j]]]);
						}
					}					
				}
			}
			
			return dataProvider;
		}
	}
}