import wollok.game.*
import froggi.*
import ui.*
import obstaculos.*
import consumibles.*
import MetaParaVictoria.*

const pantallaInicio = new Pantallas (position = game.origin(), image = "pantalla_inicio.png")
const pantallaMuerte = new Pantallas (position = game.origin(), image = "pantalla_muerte.png")
const pantallaControles = new Pantallas (position = game.at(5, 2), image = "pantalla_controles.png")

class Pantallas {
	var property position
	var property image
}

object configuracionPantallas {
	var property juegoEnMarcha = false
	
	method configurarInicio() {
		// Funcionalidad del enter para iniciar el juego
		keyboard.enter().onPressDo{if (not juegoEnMarcha) {self.configurarJuego()}}
		keyboard.t().onPressDo{if (not juegoEnMarcha and not game.hasVisual(pantallaControles)) {game.addVisual(pantallaControles)} 
								else {game.removeVisual(pantallaControles)}
		}
	}
	
	method cargarPantallaInicio(){
		game.boardGround("superficie.png")
		game.addVisual(pantallaInicio)	
	}

	
	method configurarJuego(){
		// Quita la pantalla de inicio e inicia el juego con su configuracion
		game.clear()
		game.boardGround("superficie.png")
		juegoEnMarcha = true
		configuracionJuego.agregarFroggi()
		configuracionJuego.agregarUI()
		configuracionJuego.agregarItems()
		// OBSTACULOS EN LA CALLE
		spawnerDeObstaculo.init()
		game.addVisual(new Nenufar(position = game.at(game.width()/2 - 4, game.height() - 1)))
		game.addVisual(new Nenufar(position = game.at(game.width()/2, game.height() - 1)))
		game.addVisual(new Nenufar(position = game.at(game.width()/2 + 4, game.height() - 1)))
		// agrupar los nenufares en un init
	}
	
	method pantallaMuerte() {
		game.clear()
		game.boardGround("superficie.png")
		game.addVisual(pantallaMuerte)
		juegoEnMarcha = false
		keyboard.r().onPressDo{if (not juegoEnMarcha) {self.configurarJuego()}}
	}
	
}

object configuracionJuego {
	const froggi = new Froggi()
	
	method agregarFroggi() {
		game.addVisual(froggi)
		spawnerDeObstaculo.personaje(froggi)
		keyboard.up().onPressDo { froggi.moverArriba() }
		keyboard.down().onPressDo { froggi.moverAbajo() }
		keyboard.left().onPressDo { froggi.moverIzquierda() }
		keyboard.right().onPressDo { froggi.moverDerecha() }
		game.onCollideDo(froggi, { objeto => objeto.colision(froggi) })
	}


	method agregarUI() {
		puntosUI.puntosDe(froggi)
		game.addVisual(puntosUI)
		vidasUI.vidasDe(froggi)
		game.addVisual(vidasUI)
	}
	
	method agregarItems() {
		game.onTick(3000, "CREAR FRUTA", { consumiblesManager.crearFruta() })
		game.onTick(5000, "CREAR INSECTO", { consumiblesManager.crearInsecto() })
	}
}




