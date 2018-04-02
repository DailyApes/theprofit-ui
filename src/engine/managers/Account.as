package engine.managers
{
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import engine.core.Core;

	public class Account
	{
		private var httpService:HTTPService = new HTTPService();
		
		public function Account()
		{
			httpService.addEventListener(ResultEvent.RESULT, httpService_resultHandler);
		}
		
		public function refresh():void
		{
			httpService.method = 'POST';
			httpService.url = Core.serverUrl + (Core.yii ? '/?r=' : '/') + Core.getHttpServiceModule + '/personaldata';
			httpService.requestTimeout = Core.requestTimeout;
			httpService.resultFormat = 'e4x';
			
			httpService.send();
		}
		
		private function httpService_resultHandler(event:ResultEvent):void
		{
			Core.accountData = httpService.lastResult.item;
		}
	}
}