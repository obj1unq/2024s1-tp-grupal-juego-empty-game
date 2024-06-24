import wollok.game.*
import nave.*
import nivel.*
import aliens.*
import juego.*

object pantallaInicio{
	var property position = game.at(3, 5)
	var property image = "pantallaInicio.png"
	const property sonidoMenu = "menu.mp3"

	method cargar() {
		const sonido = game.sound(self.sonidoMenu())
		game.addVisual(self)
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()})
		keyboard.up().onPressDo({sonido.volume(1)})
		keyboard.down().onPressDo({sonido.volume(0.2)})
		keyboard.m().onPressDo({sonido.volume(0)}) 
		game.addVisualIn(pressStart, game.at(6,1))
		keyboard.enter().onPressDo{ game.clear()
			sonido.stop()
			game.addVisual(new Nivel(image = "level1.png"))
			sonidoFondo.reproducirSonidoMenu()
			game.onTick(600, "INCIO", { juego.empezar()})
		}
	}
	
}
object pressStart{
	var property image = "pressStart.png"
	
}
object sonidoFondo{
	const property sonidoFondo =game.sound("sonido_fondo.mp3")
	
	method reproducirSonidoMenu(){
		sonidoFondo.play()
	}
}