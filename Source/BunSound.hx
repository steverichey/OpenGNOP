package;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

#if !desktop
import openfl.Assets;
#end

/**
 * Minimalist sound class for BunOS, mostly abstracts away SoundChannel stuff. Heavily influenced by FlxSound.
 * 
 * @author STVR
 */
class BunSound extends flash.events.EventDispatcher
{
	/**
	 * Internal tracker for paused status.
	 */
	private var _paused:Bool;
	
	/**
	 * Internal tracker for current position in sound, in milliseconds.
	 */
	private var _position:Float;
	
	/**
	 * Internal storage of volume.
	 */
	private var _volume:Float;
	
	/**
	 * Whether or not this sound should loop.
	 */
	private var _loop:Bool;
	
	/**
	 * Internal storage of the loaded sound asset.
	 */
	private var _sound:Sound;
	
	/**
	 * Internal storage of a SoundChannel object.
	 */
	private var _soundChannel:SoundChannel;
	
	/**
	 * Equivalent to 2,147,483,647. Used for number of loops; checking to see if the sound is complete, and if so, looping it, causes a crash on exit on native targets.
	 */
	private inline static var LOOPS:Int = 0x7fffffff;
	
	/**
	 * The path to sound files, as identified by the project's XML file. Neglected for desktop.
	 */
	private inline static var PATH:String = "sounds/";
	
	/**
	 * The extension of sound files. Recommend ".mp3" for flash targets. Neglected for desktop.
	 */
	private inline static var EXT:String = ".mp3";
	
	/**
	 * 	Example Usage:
	 * 
	 *	#if desktop
	 *	_sound = new BunSound( new Sound_MySound() );
	 *	#else
	 *	_sound = new BunSound( "mysound" );
	 *	#end
	 *	
	 *	add( _sound );
	 * 	_sound.play();
	 */
	
	/**
	 * Instantiate a new BunSound object by setting variables and loading a sound file. Call play() to play sound.
	 * 
	 * @param	File  A sound file to load. On desktop, include sound class; on flash, include file name but NOT path or extension.
	 */
	#if desktop
	public function new( File:Sound )
	#else
	public function new( File:String )
	#end
	{
		super();
		
		this.volume = 1.0;
		this._loop = false;
		this._paused = false;
		this._position = 0.0;
		
		try {
			#if desktop
			this._sound = File;
			#else
			this._sound = Assets.getSound( PATH + File + EXT );
			#end
		} catch ( e:Dynamic ) {
			#if debug
			throw "BunSound New() Error: " + Std.string( e );
			#end
		}
	}
	
	/**
	 * Play the previously loaded sound asset. 
	 * 
	 * @param	ForceRestart	Whether or not the sound should start again, if already playing.
	 * @param	Loop			Set to true to loop the sound 2,147,483,647 times. That's 68 years for a one second sound file.
	 */
	public function play( ForceRestart:Bool = false, Loop:Bool = false ):Void
	{
		if ( playing && !ForceRestart ) {
			return;
		}
		
		_paused = false;
		_loop = Loop;
		
		var loop:Int = ( Loop ? LOOPS : 0 );
		
		stop();
		
		_soundChannel = _sound.play( _position, loop, new SoundTransform( volume ) );
		
		// Adding this event listener does not seem to trigger the desktop crash.
		
		if ( playing ) {
			_soundChannel.addEventListener( Event.SOUND_COMPLETE, soundComplete, false, 0, true );
		}
	}
	
	/**
	 * Stops the sound asset, if playing.
	 * 
	 * @return  True if the sound was playing previously, and then stopped.
	 */
	public function stop():Bool
	{
		var success:Bool = false;
		
		if ( playing ) {
			_soundChannel.stop();
			_soundChannel = null;
			success = true;
		}
		
		// If we're not pausing, we want to resume from start
		if ( !_paused ) {
			_position = 0;
		}
		
		return success;
	}
	
	/**
	 * Call to pause the sound; essentially sets the paused flag to true and then stops the SoundChannel.
	 * 
	 * @return True if the sound was paused, false if it wasn't (i.e. the sound wasn't playing).
	 */
	public function pause():Bool
	{
		_position = _soundChannel.position;
		_paused = true;
		
		return stop();
	}
	
	/**
	 * Call to resume the sound; if paused, will start playing from where it left off. 
	 * 
	 * @return  True if the sound was paused and then resumed.
	 */
	public function resume():Bool
	{
		var success:Bool = false;
		
		if ( _paused ) {
			_paused = false;
			play( false, _loop );
			
			success = true;
		}
		
		return success;
	}
	
	/**
	 * Whether or not this sound is currently playing.
	 */
	public var playing(get, null):Bool;
	
	private function get_playing():Bool
	{
		return ( _soundChannel != null );
	}
	
	/**
	 * Whether or not this sound is currently stopped.
	 */
	public var stopped(get, null):Bool;
	
	private function get_stopped():Bool
	{
		return !playing;
	}
	
	/**
	 * Whether or not this sound has had pause() called on it.
	 */
	public var paused(get, null):Bool;
	
	private function get_paused():Bool
	{
		return _paused;
	}
	
	/**
	 * This sound's volume. Set to 1.0 by default.
	 */
	public var volume(get, set):Float;
	
	private function get_volume():Float
	{
		return _volume;
	}
	
	private function set_volume( NewVolume:Float ):Float
	{
		_volume = NewVolume;
		
		if ( _volume > 1.0 ) {
			_volume = 1.0;
		}
		
		if ( _volume < 0.0 ) {
			_volume = 0.0;
		}
		
		if ( playing ) {
			_soundChannel.soundTransform = new SoundTransform( _volume );
		}
		
		return _volume;
	}
	
	/**
	 * Internal function to null the SoundChannel when the sound is complete.
	 */
	private function soundComplete( e:Event = null ):Void
	{
		if ( playing ) {
			if ( _soundChannel.hasEventListener( Event.SOUND_COMPLETE ) ) {
				_soundChannel.removeEventListener( Event.SOUND_COMPLETE, soundComplete );
			}
		}
		
		stop();
		
		dispatchEvent( new Event( Event.SOUND_COMPLETE ) );
	}
	
	public function destroy():Void
	{
		soundComplete();
		_sound = null;
	}
}