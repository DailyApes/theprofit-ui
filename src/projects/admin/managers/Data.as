package projects.admin.managers
{
	import engine.managers.Data;
	import engine.storages.DataStorage;
	
	public class Data extends engine.managers.Data
	{
		[Bindable]
		public var modules:DataStorage = new DataStorage();
		
		[Bindable]
		public var accounts:DataStorage = new DataStorage();
		[Bindable]
		public var adminsAccounts:DataStorage = new DataStorage();
		
		[Bindable]
		public var development:DataStorage = new DataStorage();
		[Bindable]
		public var developmentStates:DataStorage = new DataStorage();
		[Bindable]
		public var developmentCategories:DataStorage = new DataStorage();
		[Bindable]
		public var developmentPriorities:DataStorage = new DataStorage();
		
		[Bindable]
		public var ideas:DataStorage = new DataStorage();
		[Bindable]
		public var ideasStates:DataStorage = new DataStorage();
		[Bindable]
		public var ideasCategories:DataStorage = new DataStorage();
		[Bindable]
		public var ideasPriorities:DataStorage = new DataStorage();
		
		public function Data()
		{
			super();
			
			modules.getHttpServiceController = 'modules';
			
			development.getHttpServiceController = 'development';
			developmentCategories.getHttpServiceController = 'developmentcategories';
			developmentStates.getHttpServiceController = 'developmentstates';
			developmentPriorities.getHttpServiceController = 'developmentpriorities';
			
			ideas.getHttpServiceController = 'ideas';
			ideasCategories.getHttpServiceController = 'ideascategories';
			ideasStates.getHttpServiceController = 'ideasstates';
			ideasPriorities.getHttpServiceController = 'ideaspriorities';
			
			accounts.getHttpServiceController = 'accounts';
			accounts.getHttpServiceAction = 'list';
			accounts.beforeChangeFunction = function():void
			{
				if (accounts.getHttpService.lastResult && accounts.getHttpService.lastResult.item)
				{
					for (var i:int = 0; i < accounts.getHttpService.lastResult.item.length(); i++) 
					{
						var label:String = String(accounts.getHttpService.lastResult.item[i]['@item_id'])
						
						if (String(accounts.getHttpService.lastResult.item[i]['@email']).length > 0)
						{
							label += ', ' + accounts.getHttpService.lastResult.item[i]['@email'];
						}
						
						if (String(accounts.getHttpService.lastResult.item[i]['@vk_id']).length > 0)
						{
							label += ', vk=' + accounts.getHttpService.lastResult.item[i]['@vk_id'];
						}
						
						accounts.getHttpService.lastResult.item[i]['@label'] = label;
					}
				}
			};
			
			adminsAccounts.getHttpServiceController = 'accounts';
			adminsAccounts.getHttpServiceAction = 'list';
			adminsAccounts.requestParams = {admins_only: 1};
						
			refreshArray = [modules, developmentStates, developmentCategories, developmentPriorities, ideasStates, ideasCategories, ideasPriorities, accounts, adminsAccounts];
		}
	}
}