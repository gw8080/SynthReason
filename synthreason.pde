PrintWriter outputx;
int constructionAttempts = 200;
int combineSize = 50;

void setup()
{
  String[] noun = loadStrings("noun.txt");
  String[] verb = loadStrings("verb.txt");
  String[] adj = loadStrings("adj.txt");
  String res = join(loadStrings("uber.txt"), "");
  String stream = "";
  for (int h = 0; h < constructionAttempts; h++ ) {
    String[] test = words(loadStrings("problem.txt")[round(random(loadStrings("problem.txt").length-1))], split(res, " "), join(noun, "\n"));
    boolean exit = false;
    if (test.length-1 == 1) {
      if (test[0].length() > 3) {
        for (int h2 = 0; h2 < constructionAttempts && exit == false; h2++ ) {
          String[] combo1 = wordsMulti( split(test[0], " ")[0], split(res, " "), join(noun, "\n"), join(verb, "\n"));
          if (combo1.length-1 == 1) {
            if (combo1[0].length() > 3) {
              for (int h3 = 0; h3 < constructionAttempts && exit == false; h3++ ) {
                String[] combo2 = words(loadStrings("prep.txt")[round(random(loadStrings("prep.txt").length-1))], split(res, " "), join(adj, "\n"));
                if (combo2.length-1 == 1) {
                  if (combo2[0].length() > 3) {
                    for (int h4 = 0; h4 < constructionAttempts && exit == false; h4++ ) {
                      String[] combo3 = wordsMulti( split(combo2[0], " ")[split(combo2[0], " ").length-1], split(res, " "), join(noun, "\n"), join(verb, "\n"));
                      if (combo3.length-1 == 1) {
                        if (combo3[0].length() > 3) {
                          stream += test[0] + "::" + combo1[0] + " " + combo3[0] + "\n";
                          exit = true;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  String[] predicate = split(stream, "\n");
  String combine = "";
  for (int x = 0; x < combineSize; ) {
    String[] test = split(predicate[round(random(predicate.length-1))], "::");
    String[] test2 = split(predicate[round(random(predicate.length-1))], "::");
    String[] test3 = split(predicate[round(random(predicate.length-1))], "::");
    if (test.length-1 == 1 && test2.length-1 == 1 && test3.length-1 == 1) {
      combine += test[0] + " " + test2[1] + " " + test3[0]+ ".\n";
      x++;
    }
  }

  outputx = createWriter("output.txt");
  outputx.println(combine);
  outputx.close();
  exit();
}

Boolean perm(String input, String input2, String adj) {
  Boolean state = false;
  String[] test = split(input, " ");
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(test.length-1));
    if ( input2.indexOf(test[rand]) > -1 && adj.indexOf("\n" + test[rand] + "\n") > -1) {
      state = true;
      break;
    }
  }

  return state;
}
String[] wordsMulti(String input2, String[] res, String verb, String noun) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-10))+4;
    if ( res[rand].equals(input2) == true) {
      if (verb.indexOf("\n" + res[rand-1] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand];
        break;
      }
      if (verb.indexOf("\n" + res[rand-2] + "\n") > -1 && verb.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state = res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
      if (verb.indexOf("\n" + res[rand-3] + "\n") > -1 && verb.indexOf("\n" + res[rand-2] + "\n") == -1 && verb.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state =  res[rand-3] + " " + res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
      if (verb.indexOf("\n" + res[rand-3] + "\n") > -1 && verb.indexOf("\n" + res[rand-2] + "\n") == -1 && verb.indexOf("\n" + res[rand-1] + "\n") == -1 && noun.indexOf("\n" + res[rand+1] + "\n") > -1) {
        state =  res[rand-3] + " " + res[rand-2] + " " + res[rand-1] + " " + res[rand] + " " + res[rand+1];
        break;
      }
    }
  }
  String[] ex = split(join(res, " "), ".");
  for (int x = 0; x < ex.length-1; x++) {
    if (ex[x].indexOf(state) > -1) {
      state += "::" + ex[x];
    }
  }
  return split(state, "::");
}
String[] words(String input, String[] res, String noun) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-5))+2;

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
  String[] ex = split(join(res, " "), ".");
  for (int x = 0; x < ex.length-1; x++) {
    if (ex[x].indexOf(state) > -1) {
      state += "::" + ex[x];
    }
  }
  return split(state, "::");
}
String wordsJoin(String input, String[] res, String adj) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-4))+2;

    if ( res[rand].equals(input) == true) {
      if (adj.indexOf("\n" + res[rand+1] + "\n") > -1 && adj.indexOf("\n" + res[rand+1] + "\n") == -1) {
        state = res[rand-1] + " " + res[rand] + " " + res[rand+1];
        break;
      }
    }
  }
  return state;
}
