package uk.co.kempt.hannah
{
   import com.neopets.projects.np9.gameEngine.NP9_DocumentExtension;
   import com.neopets.projects.np9.system.NP9_BIOS;
   
   public class HannahMoonCavesDocument extends NP9_DocumentExtension
   {
       
      
      private var _game:uk.co.kempt.hannah.Game;
      
      public var mcBIOS:NP9_BIOS;
      
      public function HannahMoonCavesDocument()
      {
         this.setupVars();
         super();
         if(this.mcBIOS.localTesting)
         {
            init(this.mcBIOS);
         }
      }
      
      private function setupVars() : void
      {
         trace("hannah: setupVars");
         this._game = new uk.co.kempt.hannah.Game();
         this.mcBIOS = this.mcBIOS != null ? this.mcBIOS : new NP9_BIOS();
         this.mcBIOS.debug = true;
         this.mcBIOS.translation = true;
         this.mcBIOS.trans_debug = false;
         this.mcBIOS.dictionary = false;
         this.mcBIOS.game_id = 1252;
         this.mcBIOS.game_lang = "en";
         this.mcBIOS.meterX = 175;
         this.mcBIOS.meterY = 425;
         this.mcBIOS.script_server = "dev.neopets.com";
         this.mcBIOS.game_server = "images50.neopets.com";
         this.mcBIOS.metervisible = true;
         this.mcBIOS.localTesting = true;
         this.mcBIOS.localPathway = "games/g" + this.mcBIOS.game_id + "/";
         this.mcBIOS.game_datestamp = "06/04/09";
         this.mcBIOS.game_timestamp = "11:31AM";
         this.mcBIOS.game_infostamp = "NeopetsVendorGameDemo";
         this.mcBIOS.iBIOSWidth = 650;
         this.mcBIOS.iBIOSHeight = 600;
         this.mcBIOS.width = this.mcBIOS.iBIOSWidth;
         this.mcBIOS.height = this.mcBIOS.iBIOSHeight;
         this.mcBIOS.useConfigFile = false;
         bOffline = true;
      }
      
      override protected function gameEngineUpdate() : void
      {
         trace("hannah: gameEngineUpdate");
         this.mcBIOS.localTesting = bOffline;
         if(bOffline)
         {
            this.mcBIOS.finalPathway = this.mcBIOS.localPathway;
         }
         else
         {
            this.mcBIOS.finalPathway = neopets_GS.getImageServer() + this.mcBIOS.localPathway;
         }
         this._game.init(this);
      }
   }
}
