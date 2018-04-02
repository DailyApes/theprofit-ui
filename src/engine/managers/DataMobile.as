package engine.managers
{
	import engine.storages.DataStorageMobile;

	public class DataMobile
	{
		[Bindable]
		public var locales:DataStorageMobile = new DataStorageMobile();
		
		public function DataMobile()
		{
			locales.getHttpServiceController = 'locales';
			locales.getHttpServiceAction = 'list';
		}
	}
}