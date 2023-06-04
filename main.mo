import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor LyricsGallery {

  // Creamos tipos específicos
  type Mensaje = Text;
  type Artista = Principal;

  // Creamos un tipo abstracto para nuestras letras de canciones
  type LetraCancion = {
    titulo : Text;
    contenido : Text;
    duracion : Nat;
    album : Text;
  };

  // Creamos el hashmap para almacenar las letras de canciones
  let letras = HashMap.HashMap<Artista, LetraCancion>(0, Principal.equal, Principal.hash);

  // Función que almacena una letra de canción en la galería
  public shared (msg) func saveLyricsInGallery(letra : LetraCancion) : async LetraCancion {
    // Obtenemos la cuenta de quien invocó la función (Artista) mediante el objeto msg que contiene el mensaje asincrónico del Actor.
    let artista : Principal = msg.caller;

    // Insertamos la letra de canción en la galería
    letras.put(artista, letra);

    // Imprimimos en el log del ambiente de desarrollo creado al ejecutar
    // dfx start en tu terminal
    Debug.print("Tu letra de canción fue almacenada correctamente en la galería " # Principal.toText(artista) # " ¡Gracias! :)");
    return letra;
  };

  // Función que obtiene una letra de canción en caso de que exista en el HashMap
  public func getLyrics(account : Artista) : async ?LetraCancion {
    let letra = letras.get(account);
    return letra;
  };

  // Función que lista todas las letras de canciones
  public func getNumberOfLyrics() : async Int {
    // Obtenemos el número de elementos del HashMap como número de letras de canciones
    letras.size();
  };

};
