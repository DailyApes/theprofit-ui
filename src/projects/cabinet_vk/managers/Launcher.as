package projects.cabinet_vk.managers
{
	import engine.components.Window;
	import engine.core.Core;
	
	import projects.cabinet.managers.Launcher;
	import projects.cabinet_vk.elements.IdentificationWindow;
	import projects.cabinet_vk.elements.LicenseWindow;
	
	
	public class Launcher extends projects.cabinet.managers.Launcher
	{
		public function Launcher()
		{
			super();
		}
		
		override public function launch(action:String, data:Object = null, parentWindow:Window = null, params:Array = null):Window
		{
			var initWindow:Boolean;
			var window:Window;
			switch(action)
			{
				case 'IdentificationWindow':
				{
					window = Core.addWindow(Core.createWindow(IdentificationWindow), data, parentWindow);
					initWindow = true;
					break;
				}
					
				case 'LicenseWindow':
				{
					window = Core.addWindow(Core.createWindow(LicenseWindow), data, parentWindow);
					initWindow = true;
					break;
				}
			}
			
			if (window)
			{
				if (initWindow)
				{
					window.init();				
				}
				return window;
			}
			else
			{
				return super.launch(action, data, parentWindow, params);
			}
		}
	}
}