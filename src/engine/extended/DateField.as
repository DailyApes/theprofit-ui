package engine.extended
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.DateField;
	
	public class DateField extends mx.controls.DateField
	{
		[Bindable]
		public var hideIcon:Boolean;
		
		public function DateField()
		{
			super();
			addEventListener(Event.CHANGE, changeHandler);
		}
		
		private function changeHandler(event:Event):void
		{
			errorString = '';
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			if (hideIcon)
			{
				this.getChildAt(1).width = 0;
				textInput.setActualSize(unscaledWidth, unscaledHeight);
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