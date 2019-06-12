class Plantas {
	const anioDeOptencion
	const property altura
	

	method toleranciaAlSol()
	
	method esFuerte(){ return self.toleranciaAlSol()> 10}
	
	method daSemillas(){ return self.esFuerte()}
	
	method espacioOcupado(){// depende de cada especie
		return 0 //inicializacion
	 }
	 method parcelaIdeal(parcela){return 0// depende de cada especie 
	 }
}


	class Menta inherits Plantas {
		override method toleranciaAlSol() = 6
		override method daSemillas() =  super() or self.altura() > 0.4
		override method espacioOcupado() = self.altura() * 3
		override method parcelaIdeal(parcela) = parcela.superficie() > 6
	}
		class  Hierbabuena 	inherits Menta{
				override method espacioOcupado() = super() * 2
				
		}		
	

	class Soja inherits Plantas{

		override method toleranciaAlSol()= if (altura < 0.5 ) { 6 } 
										else if ((0.5 < altura) and (altura < 1) ) {7}
										else 9
		override method daSemillas() = super() and  anioDeOptencion >= 2007	and altura > 1								
		override method espacioOcupado() = altura/ 2
		override method parcelaIdeal(parcela)= parcela.horasDeSol() == self.toleranciaAlSol()									
	}
			class  SojaTransgenica inherits Soja{
				override method daSemillas() =  false
				override method parcelaIdeal(parcela) = parcela.cantidadMaxima() == 1
			}	
	
	
	class Quinoa inherits Plantas{
		const property toleranciaAlSol
		override method espacioOcupado() = 0.5
		override method daSemillas() = super() or anioDeOptencion <= 2005
		override method parcelaIdeal(parcela) = parcela.plantas().any({planta =>planta.altura()>= 1.5})
	}
						
					
class Parcela {
	const property ancho 
	const property largo 
	const property horasDeSol
	var property plantas 
	

		method superficie() = ancho * largo
		method cantidadMaxima() = if (ancho > largo) {self.superficie()/ 5} else (self.superficie()/ 3) + largo 
		
		method complicaciones() = plantas.any({planta => planta.toleranciaAlSol() < horasDeSol}) 
		method plantarUnaPlanta(unaPlanta)=if (self.cantidadMaxima() >= (plantas.size()) +1 or 
												horasDeSol >= (unaPlanta.toleranciaAlSol()) + 2)   {
													error.throwWithMessage("Se supero la cantidad maxima o recibe mas sol de los que tolera la planta ")
												}else plantas.add(unaPlanta)
		
		method esEcologica(){return not self.complicaciones()}
		
		method esIndustrial() = plantas.size()> 2
		
		method plantaSeAsociaAEcologica(planta) = planta.parcelaIdeal(self)
		
		method plantaSeAsociaAIndustrial(planta) = planta.esFuerte()
		
		method plantasBienAsociadas() = if (self.esEcologica()){
								plantas.filter({planta => self.plantaSeAsociaAEcologica(planta)})
								}else plantas.filter({planta => self.plantaSeAsociaAIndustrial(planta)})
}
object inta{
	var property  parcelas =[]
	
	method cantidadTotalDePlantas()= parcelas.sum({parcela => parcela.plantas().size()})
	method cantidadDeParcelas() = parcelas.size()
	method promedioPlantas()= self.cantidadTotalDePlantas()/ self.cantidadDeParcelas()
	
	
	
	method parcelasConMasDe4()= parcelas.filter({parcela => ((parcela.plantas().size()) > 4) })
	
	method masAutosustentable() = self.parcelasOrdenadasAutosustentable().first()
		/// retorna el primero 
		
	method parcelasOrdenadasAutosustentable() =self.parcelasConMasDe4().sortedBy { parcela1, parcela2 => parcela1.plantasBienAsociadas() > parcela1.plantasBienAsociadas()
	///ordena de mayor a menor segun la cantidad de parcelas bien asociadas que tengan 
		
		
	}
	
}

	





		