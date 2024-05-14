import wollok.game.*
import froggi.*
import randomizer.*


class Banana{
	
	var property position = randomizer.emptyPosition()
	const property puntosQueAporta = 300
	
	method image(){
		return "banana.png"
	}
	
	method colision(objeto){
		objeto.agregarPuntos(puntosQueAporta)
		game.removeVisual(self)
		frutasManager.frutas().remove(self)
	}
	
}

class Uva{
	var property position = randomizer.emptyPosition()
	const property puntosQueAporta = 200
	
	
	method image(){
		return "uva.png"
	}	
	
	method colision(objeto){
		objeto.agregarPuntos(puntosQueAporta)
		game.removeVisual(self)
		frutasManager.frutas().remove(self)
	}	
}

class Manzana{
	
	var property position = randomizer.emptyPosition()
	const property puntosQueAporta = 100
	
	method image(){
		return "manzana-roja.png"
	}
		
	method colision(objeto){
		objeto.agregarPuntos(puntosQueAporta)
		game.removeVisual(self)
		frutasManager.frutas().remove(self)
	}

}

object uvaFactory {
	
	method crearFruta(){
		const uva = new Uva()
		game.addVisual(uva)
		return uva
	}
	
}

object bananaFactory {
	
	method crearFruta() {
		const banana = new Banana()
		game.addVisual(banana)
		return banana
	}
}

object manzanaFactory {


	method crearFruta() {
		const manzana = new Manzana()
		game.addVisual(manzana)
		return manzana
	}

}

object frutasManager{
	
	const property frutas = []
	
	method crearFruta() {
		if (frutas.size() < 9) {
			frutas.add([ manzanaFactory, uvaFactory , bananaFactory ].anyOne().crearFruta())
		}
	}
	
}