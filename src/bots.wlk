class Imagen {
    var nombre
    var tamanio    
}




class Tweet {
    var texto
    var imagen
    var usuario
    method texto() = texto
    method usuario() = usuario
    method contiene(palabra){
        return texto.contains(palabra)
    }
    method esDemasiadoLargo(){
        return texto.size() > 15
    }
    method aQuienSeDirige(){
        return texto.filter({palabra => palabra.startsWith("@")}).first()
    }
    
    method esALaNada(){
        return self.aQuienSeDirige() == ""
    }
}

object pdpwitter { 
    var tweets = []
    var bots = [benito, 
        new BotPublicitario(palabra = 'comida', link = 'www.google.com', nombre = 'soloEmpanadas', imagen = new Imagen(nombre = 'hola', tamanio = 120) )
        ]    
    method recibirTweet(tweet){
        if(tweet.esDemasiadoLargo()){
            error.throwWithMessage("Tweet demasiado largo")
        }
        tweets.add(tweet)
        self.botsParaResponder(tweet).forEach({ bot => bot.responder(tweet)})
    }
    
    method agregarBot(bot){
        bots.add(bot)
    }
    
    method botsParaResponder(tweet){
        return bots.filter({bot=>bot.cumpleCondiciones(tweet)})
    }
    method tweetsParaUsuario(usuario){
        return tweets.filter({tweet => tweet.contiene("@" + usuario)})    
    }    
    
    method tweetsALaNada(){
        return tweets.filter({ tweet=> tweet.esALaNada() })
    }
}
 
object policia {
    var tweetsIlegales = []
    method guardarTweet(tweet){
        tweetsIlegales.add(tweet)
    }
}

object benito {    
    const palabras = ['droga', 'falopa']
    method cumpleCondiciones(tweet){
        return palabras.any({ palabra => tweet.texto().contains(palabra) })
    }
    method responder(tweet){
        policia.guardarTweet(tweet)            
    }
}

class BotPublicitario {
    var palabra
    var link
    var nombre
    var imagen
    
    method cumpleCondiciones(tweet){
        return tweet.texto().contains(palabra)
    }
    
    method responder(tweet){
        pdpwitter.recibirTweet(new Tweet(texto = ['@' + tweet.usuario(), link], imagen = imagen, usuario = nombre))    
    }
}


class BotAnalista {
    var tweets = []
    method cumpleCondiciones(tweet){
        return true
    }
    method responder(tweet){
        tweets.add(tweet)
    }
}


