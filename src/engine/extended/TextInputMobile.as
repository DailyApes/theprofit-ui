package engine.extended
{
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	import engine.core.CoreMobile;
	
	public class TextInputMobile extends spark.components.TextInput
	{
		[Bindable]
		public var validate:Boolean;
		
		public function TextInputMobile()
		{
			super();
			
			addEventListener(TextOperationEvent.CHANGE, changeHandler);
		}
		
		private function changeHandler(event:TextOperationEvent):void
		{
			validation();
		}
		
		public function validation():Boolean
		{
			if (validate)
			{
				if (text.length > 0)
				{
					errorString = '';
					return true;
				}
				
				setFocus();
				errorString = CoreMobile.translate.to(['required', 'to_fill']);
			}
			
			return false;
		}
	}
}