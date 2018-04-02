package engine.managers
{
	import flash.events.Event;
	
	import engine.core.Core;
	import engine.storages.DataStorage;

	public dynamic class Data
	{
		[Bindable]
		public var refreshArray:Array = new Array();
		
		[Bindable]
		public var locales:DataStorage = new DataStorage();
		[Bindable]
		public var yesNo:DataStorage = new DataStorage();
		
		public function Data()
		{
			locales.addEventListener(Event.CHANGE, locales_changeHandler);
			locales.getHttpServiceUrl = '/static/locales/locales.xml?' + Math.random();
			
			yesNo.dataProvider = new XML(
				<root>
					<item item_id="0" name="no"/>
					<item item_id="1" name="yes"/>
				</root>).item;
		}
		
		public function refresh():void
		{
			for (var i:int = 0; i < refreshArray.length; i++) 
			{
				refreshArray[i].refresh();
			}
		}
		
		protected function locales_changeHandler(event:Event):void
		{
			Core.initialize();
		}
	}
}