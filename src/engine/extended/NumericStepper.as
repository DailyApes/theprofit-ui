package engine.extended
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.NumericStepper;
	
	public class NumericStepper extends spark.components.NumericStepper
	{
		[Bindable]
		public var deltaInterval:Number = 1;
		
		public function NumericStepper()
		{
			super();
			addEventListener(Event.CHANGE, changeHandler);
		}
		
		private function changeHandler(event:Event):void
		{
			errorString = '';
		}
		
		override protected function system_mouseWheelHandler(event:MouseEvent):void
		{
			if (!event.isDefaultPrevented())
			{
				var newValue:Number = nearestValidValue(value + (event.delta > 0 ? deltaInterval : -deltaInterval), stepSize);
				setValue(newValue);
				dispatchEvent(new Event(Event.CHANGE));
				event.preventDefault();
			}
		}
		
		override public function set errorString(value:String):void
		{
			super.errorString = value;
			
			if (value && value.length > 0)
			{
				callLater(function():void
				{
					dispatchEvent(new MouseEvent("mouseOut"));
					dispatchEvent(new MouseEvent("mouseOver"));
				});
			}
		}
	}
}