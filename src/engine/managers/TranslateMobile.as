package engine.managers
{
	import flash.events.Event;
	
	import mx.resources.ResourceBundle;
	
	import spark.components.Group;
	
	import engine.core.CoreMobile;
	
	public class TranslateMobile extends Group
	{
		public function Translate():void
		{
			resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler);

			CoreMobile.data.locales['addEventListener'](Event.CHANGE, locales_changeHandler);
			CoreMobile.data.locales.refresh();
		}
		
		private function resourceManager_changeHandler(event:Event):void
		{
			dispatchEvent(new Event('change'));
		}
		
		private function locales_changeHandler(event:Event):void
		{
			var languageResources:Object = new Object();
			
			for (var i:int = 0; i < CoreMobile.data.locales.dataProvider.length(); i++) 
			{
				for (var j:int = 1; j < CoreMobile.data.locales.dataProvider[i].attributes().length(); j++) 
				{
					var locale:String = CoreMobile.data.locales.dataProvider[i].attributes()[j].name().toString();
					var value:String = CoreMobile.data.locales.dataProvider[i].attributes()[j].toString();
					
					if (!languageResources[locale])
					{
						languageResources[locale] = new ResourceBundle(locale, "system");
					}
					languageResources[locale].content[CoreMobile.data.locales.dataProvider[i].@locale] = value;
				}
			}
			
			for (var item:Object in languageResources) 
			{
				resourceManager.addResourceBundle(languageResources[item]);
			}
			
			resourceManager.localeChain = ['ru_RU'];
			
			dispatchEvent(new Event('change'));
		}
		
		[Bindable ('change')]
		public function to(array:Array, delimiter:String = ' '):String
		{
			var string:String = '';
			
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] !== '\n')
				{
					var value:String = resourceManager.getString('system', array[i]);
					string += value ? value : array[i];
					
					if (i < array.length - 1)
					{
						string += delimiter;
					}
				}
				else
				{
					string += '\n';
				}
			}
			
			return string;
		}
	}
}