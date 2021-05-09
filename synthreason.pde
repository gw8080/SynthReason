PrintWriter outputx;
int attempts = 100;
void setup()
{
  String[] noun = loadStrings("noun.txt");
  String[] verb = loadStrings("verb.txt");
  String res = join(loadStrings("n.txt"), "");
  String stream = "";
  for (int h = 0; h < attempts; h++ ) {
    String test = words("of", split(res, " "), join(noun, "\n"));
    boolean exit = false;
    for (int h2 = 0; h2 < attempts && exit == false; h2++ ) {
      String combo1 = wordsMulti( split(test, " ")[0], split(res, " "), join(verb, "\n"));
      if (combo1.length() > 3 ) {
        for (int h3 = 0; h3 < attempts && exit == false; h3++ ) {
          String combo2 = wordsMulti( split(test, " ")[split(test, " ").length-1], split(res, " "), join(verb, "\n"));
          if (combo2.length() > 3 ) {
            stream += test + ": " + combo1 + " then " + combo2 + ".\n";
            exit = true;
          }
        }
      }
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(stream);
  outputx.close();
  exit();
}
String wordsMulti(String input2, String[] res, String verb) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-4))+2;
    if ( res[rand].equals(input2) == true) {
      if (verb.indexOf("\n" + res[rand-1] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand];
        break;
      }
      if (verb.indexOf("\n" + res[rand-2] + "\n") > -1 && verb.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state = res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
      if (verb.indexOf("\n" + res[rand-3] + "\n") > -1 && verb.indexOf("\n" + res[rand-2] + "\n") == -1  && verb.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state =  res[rand-3] + " " + res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
    }
  }
  return state;
}
String words(String input, String[] res, String noun) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-4))+2;

    if ( res[rand].equals(input) == true) {
      if (noun.indexOf("\n" + res[rand+1] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand] + " " + res[rand+1];
        break;
      }
      if (noun.indexOf("\n" + res[rand+1] + "\n") == -1 && noun.indexOf("\n" + res[rand+2] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand] + " " + res[rand+1] + " " + res[rand+2];
        break;
      }
    }
  }
  return state;
}
