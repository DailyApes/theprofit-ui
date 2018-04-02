package engine.extended
{
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	import engine.core.Core;
	import engine.skins.TextInputSkin;
	
	public class TextInput extends spark.components.TextInput
	{
		[Bindable]
		public var validate:Boolean;
		
		public function TextInput()
		{
			super();
			
			setStyle('skinClass', TextInputSkin);
			addEventListener(TextOperationEvent.CHANGE, changeHandler);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
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
				errorString = Core.translate.to(['required', 'to_fill']);
			}
			else
			{
				errorString = '';
			}
			
			return false;
		}
		
		override public function set errorString(value:String):void
		{
			super.errorString = value;
			
			if (value && value.length > 0)
			{
				Core.callAfter(function():void
				{
					if (parentDocument && parentDocument.enabled && parentDocument.visible)
					{
						dispatchEvent(new MouseEvent("mouseOut"));
						dispatchEvent(new MouseEvent("mouseOver"));	
					}
				}, 100);
			}
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			/*var menu:ContextMenu = textDisplay['contextMenu'];

			selectable = true;
			editable = true;
			
			if (contextMenu == null || !contextMenu.clipboardMenu)
			{
				menu.clipboardMenu = true;
				contextMenu = menu;
				removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			}*/
		}
	}
}