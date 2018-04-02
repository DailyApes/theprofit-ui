package projects.cabinet.managers
{
	import engine.managers.Data;
	import engine.storages.DataStorage;
	
	public class Data extends engine.managers.Data
	{
		[Bindable]
		public var modules:DataStorage = new DataStorage();
		
		[Bindable]
		public var direction:DataStorage = new DataStorage();
		[Bindable]
		public var periodicity:DataStorage = new DataStorage();

		[Bindable]
		public var haContacts:DataStorage = new DataStorage();
		[Bindable]
		public var haContactsGroups:DataStorage = new DataStorage();
		
		[Bindable]
		public var haWallets:DataStorage = new DataStorage();
		[Bindable]
		public var haWalletsGroups:DataStorage = new DataStorage();
		
		[Bindable]
		public var haContributions:DataStorage = new DataStorage();
		[Bindable]
		public var haContributionsGroups:DataStorage = new DataStorage();
		
		public function Data()
		{
			super();
			modules.getHttpServiceController = 'modules';
			
			haContacts.getHttpServiceController = 'hacontacts';
			haContactsGroups.getHttpServiceController = 'hacontactsgroups';
			
			haWallets.getHttpServiceController = 'hawallets';
			haWalletsGroups.getHttpServiceController = 'hawalletsgroups';
			
			haContributions.getHttpServiceController = 'hacontributions';
			haContributionsGroups.getHttpServiceController = 'hacontributionsgroups';
			
			direction.dataProvider = new XML(
				<root>
					<item item_id="1" name="income"/>
					<item item_id="0" name="outcome"/>
				</root>).item;
			
			periodicity.dataProvider = new XML(
				<root>
					<item item_id="1" name="once"/>
					<item item_id="2" name="daily"/>
					<item item_id="3" name="weekly"/>
					<item item_id="4" name="monthly"/>
					<item item_id="5" name="quarterly"/>
					<item item_id="6" name="annually"/>
					<item item_id="7" name="everys n days"/>
				</root>).item;
			
			refreshArray = [modules, haContacts, haContactsGroups, haWallets, haWalletsGroups, haContributions, haContributionsGroups];
		}
	}
}