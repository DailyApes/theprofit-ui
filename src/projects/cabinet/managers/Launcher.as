package projects.cabinet.managers
{
	
	import engine.components.Window;
	import engine.core.Core;
	import engine.elements.RegistrationWindow;
	import engine.managers.Launcher;
	
	import projects.cabinet.elements.HelpWindow;
	import projects.cabinet.elements.IdentificationWindow;
	import projects.cabinet.elements.VideotutorialWindow;
	import projects.cabinet.elements.contactswindow.ContactsWindow;
	import projects.cabinet.elements.hawindow.HAWindow;
	import projects.cabinet.elements.hawindow.elements.HAEditWindow;
	import projects.cabinet.elements.hawindow.elements.charts.HAByContributionsChartWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontactsreferencewindow.HAContactsReferenceWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontactsreferencewindow.elements.HAContactsReferenceEditGroupWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontactsreferencewindow.elements.HAContactsReferenceEditWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontributionsreferencewindow.HAContributionsReferenceWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontributionsreferencewindow.elements.HAContributionsReferenceEditGroupWindow;
	import projects.cabinet.elements.hawindow.elements.references.hacontributionsreferencewindow.elements.HAContributionsReferenceEditWindow;
	import projects.cabinet.elements.hawindow.elements.references.hawalletsreferencewindow.HAWalletsReferenceWindow;
	import projects.cabinet.elements.hawindow.elements.references.hawalletsreferencewindow.elements.HAWalletsReferenceEditGroupWindow;
	import projects.cabinet.elements.hawindow.elements.references.hawalletsreferencewindow.elements.HAWalletsReferenceEditWindow;
	import projects.cabinet.elements.reports.BalanceRefillsHistoryWindow;
	import projects.cabinet.elements.reports.PaymentsHistoryWindow;
	import projects.cabinet.elements.sbwindow.SBWindow;
	
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
					
				case 'RegistrationWindow':
				{
					window = Core.addWindow(Core.createWindow(RegistrationWindow), data, parentWindow);
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
					
				case 'VideotutorialWindow':
				{
					window = Core.selectWindow(VideotutorialWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(VideotutorialWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'HAWindow':
				{
					window = Core.selectWindow(HAWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HAWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'HAEditWindow':
				{
					window = Core.addWindow(Core.createWindow(HAEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAWalletsReferenceWindow':
				{
					window = Core.selectWindow(HAWalletsReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HAWalletsReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'HAWalletsReferenceEditGroupWindow':
				{
					window = Core.addWindow(Core.createWindow(HAWalletsReferenceEditGroupWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAWalletsReferenceEditWindow':
				{
					window = Core.addWindow(Core.createWindow(HAWalletsReferenceEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAContactsReferenceWindow':
				{
					window = Core.selectWindow(HAContactsReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HAContactsReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'HAContactsReferenceEditGroupWindow':
				{
					window = Core.addWindow(Core.createWindow(HAContactsReferenceEditGroupWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAContactsReferenceEditWindow':
				{
					window = Core.addWindow(Core.createWindow(HAContactsReferenceEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAContributionsReferenceWindow':
				{
					window = Core.selectWindow(HAContributionsReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HAContributionsReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'HAContributionsReferenceEditGroupWindow':
				{
					window = Core.addWindow(Core.createWindow(HAContributionsReferenceEditGroupWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'HAContributionsReferenceEditWindow':
				{
					window = Core.addWindow(Core.createWindow(HAContributionsReferenceEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'ContactsWindow':
				{
					window = Core.selectWindow(ContactsWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(ContactsWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'BalanceRefillsHistoryWindow':
				{
					window = Core.selectWindow(BalanceRefillsHistoryWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(BalanceRefillsHistoryWindow), data, parentWindow);
						initWindow = true;
					}
					else
					{
						window.reloadFunction();
					}
					break;
				}
					
				case 'PaymentsHistoryWindow':
				{
					window = Core.selectWindow(PaymentsHistoryWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(PaymentsHistoryWindow), data, parentWindow);
						initWindow = true;
					}
					else
					{
						window.reloadFunction();
					}
					break;
				}
					
				case 'HAByContributionsChartWindow':
				{
					window = Core.selectWindow(HAByContributionsChartWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(HAByContributionsChartWindow), data, parentWindow);
						initWindow = true;
					}
					else
					{
						window.reloadFunction();
					}
					break;
				}
					
				//---- SB
					
				case 'SBWindow':
				{
					window = Core.selectWindow(SBWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(SBWindow), data, parentWindow);
						initWindow = true;
					}
						
					else
					{
						window.reloadFunction();
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