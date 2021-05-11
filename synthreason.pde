PrintWriter outputx;
int constructionAttempts = 200;
int combineSize = 50;

void setup()
{

  String[] vocab = split(join(loadStrings("noun.txt"), "\n") + "::" + join(loadStrings("verb.txt"), "\n") + "::" + join(loadStrings("adj.txt"), "\n") + "::" + join(loadStrings("problem.txt"), "\n") + "::" + join(loadStrings("prep.txt"), "\n"), "::");

  String res = join(loadStrings("uber.txt"), "");
  String stream = "";
  for (int h = 0; h < constructionAttempts; h++ ) {
    String[] one = split(vocab[0], "\n");
    String[] two = split(vocab[3], "\n");
    String[] three = split(vocab[1], "\n");
    String[] four = split(vocab[4], "\n");
    String[] five = split(vocab[1], "\n");
    String[] test = words(four[round(random(four.length-1))], split(res, " "), join(one, "\n"));
    boolean exit = false;
    if (test.length-1 == 1) {
      if (test[0].length() > 3) {
        for (int h2 = 0; h2 < constructionAttempts && exit == false; h2++ ) {
          String[] combo1 = wordsMulti( split(test[0], " ")[0], split(res, " "), join(one, "\n"), join(two, "\n"));
          if (combo1.length-1 == 1) {
            if (combo1[0].length() > 3) {
              for (int h3 = 0; h3 < constructionAttempts && exit == false; h3++ ) {
                String[] combo2 = words(five[round(random(five.length-1))], split(res, " "), join(three, "\n"));
                if (combo2.length-1 == 1) {
                  if (combo2[0].length() > 3) {
                    for (int h4 = 0; h4 < constructionAttempts && exit == false; h4++ ) {
                      String[] combo3 = wordsMulti( split(combo2[0], " ")[split(combo2[0], " ").length-1], split(res, " "), join(one, "\n"), join(two, "\n"));
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

Boolean perm(String input, String input2, String three) {
  Boolean state = false;
  String[] test = split(input, " ");
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(test.length-1));
    if ( input2.indexOf(test[rand]) > -1 && three.indexOf("\n" + test[rand] + "\n") > -1) {
      state = true;
      break;
    }
  }

  return state;
}
String[] wordsMulti(String input2, String[] res, String two, String one) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-10))+4;
    if ( res[rand].equals(input2) == true) {
      if (two.indexOf("\n" + res[rand-1] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand];
        break;
      }
      if (two.indexOf("\n" + res[rand-2] + "\n") > -1 && two.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state = res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
      if (two.indexOf("\n" + res[rand-3] + "\n") > -1 && two.indexOf("\n" + res[rand-2] + "\n") == -1 && two.indexOf("\n" + res[rand-1] + "\n") == -1) {
        state =  res[rand-3] + " " + res[rand-2] + " " + res[rand-1] + " " + res[rand];
        break;
      }
      if (two.indexOf("\n" + res[rand-3] + "\n") > -1 && two.indexOf("\n" + res[rand-2] + "\n") == -1 && two.indexOf("\n" + res[rand-1] + "\n") == -1 && one.indexOf("\n" + res[rand+1] + "\n") > -1) {
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
String[] words(String input, String[] res, String one) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-5))+2;

    if ( res[rand].equals(input) == true) {
      if (one.indexOf("\n" + res[rand+1] + "\n") > -1) {
        state = res[rand-1] + " " + res[rand] + " " + res[rand+1];
        break;
      }
      if (one.indexOf("\n" + res[rand+1] + "\n") == -1 && one.indexOf("\n" + res[rand+2] + "\n") > -1) {
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
String wordsJoin(String input, String[] res, String three) {
  String state = "";
  for (int x = 0; x < 10000; x++ ) {
    int rand = round(random(res.length-4))+2;

    if ( res[rand].equals(input) == true) {
      if (three.indexOf("\n" + res[rand+1] + "\n") > -1 && three.indexOf("\n" + res[rand+1] + "\n") == -1) {
        state = res[rand-1] + " " + res[rand] + " " + res[rand+1];
        break;
      }
    }
  }
  return state;
}
