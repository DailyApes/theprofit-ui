package projects.admin.managers
{
	import engine.components.Window;
	import engine.core.Core;
	import engine.elements.stickynoteswindow.StickyNotesWindow;
	import engine.managers.Launcher;
	
	import projects.admin.elements.HelpEditorWindow;
	import projects.admin.elements.HelpWindow;
	import projects.admin.elements.IdentificationWindow;
	import projects.admin.elements.TextEditorWindow;
	import projects.admin.elements.references.accountsreferencewindow.AccountsReferenceWindow;
	import projects.admin.elements.references.accountsreferencewindow.elements.AccountsReferenceEditWindow;
	import projects.admin.elements.references.modulesreferencewindow.ModulesReferenceWindow;
	import projects.admin.elements.reports.LogsReportWindow;
	import projects.admin.elements.reports.PaymentsReportWindow;
	
	public class Launcher extends engine.managers.Launcher
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
					
				case 'AccountsReferenceWindow':
				{
					window = Core.selectWindow(AccountsReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(AccountsReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'AccountsReferenceEditWindow':
				{
					window = Core.addWindow(Core.createWindow(AccountsReferenceEditWindow), data, parentWindow);
					window.action = params[0];
					initWindow = true;
					break;
				}
					
				case 'HelpWindow':
				{
					window = Core.selectWindow(HelpWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HelpWindow));
						initWindow = true;
					}
					break;
				}
					
				case 'HelpEditorWindow':
				{
					//window = Core.selectWindow(HelpEditorWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HelpEditorWindow));
						initWindow = true;
					}
					break;
				}
					
				case 'StickyNotesWindow':
				{
					window = Core.selectWindow(StickyNotesWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(StickyNotesWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'ModulesReferenceWindow':
				{
					window = Core.selectWindow(ModulesReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(ModulesReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'PaymentsReportWindow':
				{
					window = Core.selectWindow(PaymentsReportWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(PaymentsReportWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'LogsReportWindow':
				{
					window = Core.selectWindow(LogsReportWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(LogsReportWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'TextEditorWindow':
				{
					//window = Core.selectWindow(TextEditorWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(TextEditorWindow), data, parentWindow);
						initWindow = true;
					}
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