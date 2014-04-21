/*global Main*/
/*global PIXI*/
/*global Icon*/
/*global window*/

OS7.onLoad = function()
{
	var gnopWindow;
	
	var fileText = ["New Game", "LINE", "Quit"];
	var fileFunctions = [function(){}, null, function(){}];
	var fileDrop = new OS7.DropMenu(fileText, fileFunctions);
	
	var paddleText = ["GREY_Player", "TAB_Small", "TAB_Normal", "TAB_Large", "LINE", "GREY_Computer", "TAB_Small", "TAB_Normal", "TAB_Large"];
	var paddleFunctions = [];
	var paddleDrop = new OS7.DropMenu(paddleText, paddleFunctions);
	
	var ballText = ["Small", "Normal", "Large", "LINE", "Slow", "Normal", "Fast"];
	var ballFunctions = [];
	var ballDrop = new OS7.DropMenu(ballText, ballFunctions);
	
	var optionsText = ["Novice", "Intermediate", "Expert", "LINE", "Set Ending Score...", "LINE", "Computer Serves First", "You Serve First", "LINE", "Sound"];
	var optionsFunctions = [];
	var optionsDrop = new OS7.DropMenu(optionsText, optionsFunctions);
	
	var helpText = ["Instructions"];
	var helpFunctions = [];
	var helpDrop = new OS7.DropMenu(helpText, helpFunctions);
	
	var topMenuItems = [];
	topMenuItems.push(new OS7.MenuItem("File", fileDrop, 0, null, gnopWindow));
	topMenuItems.push(new OS7.MenuItem("Paddle", paddleDrop, 0, null, gnopWindow));
	topMenuItems.push(new OS7.MenuItem("Ball", ballDrop, 0, null, gnopWindow));
	topMenuItems.push(new OS7.MenuItem("Options", optionsDrop, 0, null, gnopWindow));
	topMenuItems.push(new OS7.MenuItem("Help", helpDrop, 0, null, gnopWindow));
	
	var gnopTop = new OS7.TopMenu(topMenuItems);
	gnopWindow = new OS7.Window(69, 94, 502, 312, OS7.Window.SHADOWED, gnopTop);
	gnopWindow.addImage("assets/images/splash.png", 57, 49);
	
	OS7.MainDesktop.addIcon("assets/images/icon.png", 40, 40, gnopWindow);
};