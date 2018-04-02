package engine.managers
{
	import mx.managers.PopUpManager;
	
	import engine.components.Window;
	import engine.components.notes.elements.EditNoteWindow;
	import engine.components.texteditor.elements.ATagWindow;
	import engine.components.texteditor.elements.FontTagWindow;
	import engine.components.texteditor.elements.ImgTagWindow;
	import engine.core.Core;
	import engine.elements.BarcodeIdentificationWindow;
	import engine.elements.BasicApiIdentificationWindow;
	import engine.elements.CalculatorWindow;
	import engine.elements.ConfirmWindow;
	import engine.elements.PayModuleWindow;
	import engine.elements.PersonalDataWindow;
	import engine.elements.RefillBalanceWindow;
	import engine.elements.ResolutionWindow;
	import engine.elements.SupportUsWindow;
	import engine.elements.developmentwindow.DevelopmentWindow;
	import engine.elements.developmentwindow.elements.DevelopmentEditWindow;
	import engine.elements.developmentwindow.elements.references.DevelopmentCategoriesReferenceWindow;
	import engine.elements.developmentwindow.elements.references.DevelopmentPrioritiesReferenceWindow;
	import engine.elements.developmentwindow.elements.references.DevelopmentStatesReferenceWindow;
	import engine.elements.ideaswindow.IdeasWindow;
	import engine.elements.ideaswindow.elements.IdeasEditWindow;
	import engine.elements.localeswindow.LocalesWindow;
	import engine.elements.localeswindow.elements.LocalesEditWindow;
	import engine.elements.startwindow.StartWindow;
	
	public class Launcher
	{
		public function Launcher()
		{

		}
		
		public function launch(action:String, data:Object = null, parentWindow:Window = null, params:Array = null):Window
		{
			var initWindow:Boolean;
			var window:Window;
			switch(action)
			{
				case 'BarcodeIdentificationWindow':
				{
					window = Core.addWindow(Core.createWindow(BarcodeIdentificationWindow), data, parentWindow);
					initWindow = true;
					break;
				}
					
				case 'StartWindow':
				{
					window = Core.selectWindow(StartWindow);
					if (!window)
					{
						window = Core.createWindow(StartWindow);
						PopUpManager.addPopUp(window, Core.application.viewport);
						initWindow = true;
					}
					break;
				}
					
				case 'ConfirmWindow':
				{
					window = Core.addWindow(Core.createWindow(ConfirmWindow), data, parentWindow);
					initWindow = true;
					break;
				}
					
				case 'LocalesWindow':
				{
					window = Core.selectWindow(LocalesWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(LocalesWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}	
					
				case 'LocalesEditWindow':
				{
					window = Core.addWindow(Core.createWindow(LocalesEditWindow), data, parentWindow);
					window.action = params[0];
					initWindow = true;
					break;
				}
					
				case 'IdeasWindow':
				{
					window = Core.selectWindow(IdeasWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(IdeasWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'IdeasEditWindow':
				{
					window = Core.addWindow(Core.createWindow(IdeasEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'DevelopmentWindow':
				{
					window = Core.selectWindow(DevelopmentWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(DevelopmentWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'DevelopmentCategoriesReferenceWindow':
				{
					window = Core.selectWindow(DevelopmentCategoriesReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(DevelopmentCategoriesReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'DevelopmentPrioritiesReferenceWindow':
				{
					window = Core.selectWindow(DevelopmentPrioritiesReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(DevelopmentPrioritiesReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'DevelopmentStatesReferenceWindow':
				{
					window = Core.selectWindow(DevelopmentStatesReferenceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(DevelopmentStatesReferenceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'DevelopmentEditWindow':
				{
					window = Core.addWindow(Core.createWindow(DevelopmentEditWindow), data, parentWindow);
					window.action = params[0];
					window.mode = params[1];
					initWindow = true;
					break;
				}
					
				case 'CalculatorWindow':
				{
					window = Core.addWindow(Core.createWindow(CalculatorWindow), data, parentWindow);
					window.action = params[0];
					window['numericStepper'] = params[1];
					initWindow = true;
					break;
				}
					
				case 'PersonalDataWindow':
				{
					window = Core.selectWindow(PersonalDataWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(PersonalDataWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'ResolutionWindow':
				{
					window = Core.selectWindow(ResolutionWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(ResolutionWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'BasicApiIdentificationWindow':
				{
					window = Core.selectWindow(BasicApiIdentificationWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(BasicApiIdentificationWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'EditNoteWindow':
				{
					window = Core.addWindow(Core.createWindow(EditNoteWindow), data, parentWindow);
					window.action = params[0];
					initWindow = true;
					break;
				}
					
				case 'ATagWindow':
				{
					window = Core.selectWindow(ATagWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(ATagWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'FontTagWindow':
				{
					window = Core.selectWindow(FontTagWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(FontTagWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'ImgTagWindow':
				{
					window = Core.selectWindow(ImgTagWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(ImgTagWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'RefillBalanceWindow':
				{
					window = Core.selectWindow(RefillBalanceWindow);
					if (!window)
					{
						window = Core.addWindow(Core.createWindow(RefillBalanceWindow), data, parentWindow);
						initWindow = true;
					}
					break;
				}
					
				case 'PayModuleWindow':
				{
					window = Core.addWindow(Core.createWindow(PayModuleWindow), data, parentWindow);
					initWindow = true;
					break;
				}
					
				case 'SupportUsWindow':
				{
					window = Core.addWindow(Core.createWindow(SupportUsWindow), data, parentWindow);
					initWindow = true;
					break;
				}
			}
			
			if (initWindow)
			{
				window.init();				
			}
			return window;
			//for extended override after
		}
	}
}