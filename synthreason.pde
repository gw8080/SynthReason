String mode = "nlp";// "nlp" = generate simulation, will overwrite current mental simulation. "nlp" = generate natural language using mental simulation data. Generate mental simulation first!
//NLP parameters
PrintWriter vocabx;
PrintWriter outputx;
int mainLoops = 3;
String NLPFunction = "recall";// "generate" or "recall" NLP structures.
String ruleList = "3,2,0,1,1,4,1,1:3,2,3,1,3,4,2,2:2,1,3,2,2,1,3,0:3,2,4,1,1,3,3,3:1,3,0,3,3,4,4,2:1,2,1,3,3,4,3,2:2,1,2,3,1,3,2,4:2,2,2,1,1,1,2,1:2,0,2,3,4,4,1,0:"; // custom rulelist for NLP structure
//simulation parameters
PrintWriter status;
int realityConstructionAttempts = 5000;
int functionChances = 10000;
int iterations = 50;
int retryLimit = 4;
String mentalResource = "exp.txt";
String mentalResource2 = "uber.txt";
String NLP_Resource = "uber.txt";
String sim_Resource = "sim.txt";
void setup()
{
  String stream = "";
  String simulationData = join(loadStrings(sim_Resource), "\n");
  if (mode.equals("sim") == true) {
    simulationData = createSimulation();
    vocabx = createWriter(sim_Resource);
    vocabx.println(simulationData);
    vocabx.close();
  }
  if (mode.equals("nlp") == true) {
    int n = 0;
    String[] vocab = split(join(loadStrings("noun.txt"), "\n") + "::" + join(loadStrings("verb.txt"), "\n") + "::" + join(loadStrings("adj.txt"), "\n") + "::" + join(loadStrings("problem.txt"), "\n") + "::" + join(loadStrings("prep.txt"), "\n"), "::");
    String res = join(loadStrings(NLP_Resource), "");
    int G1 = 0, G2 = 0, G3 = 0, G4 = 0, G5 = 0, G6 = 0, G7 = 0, G8 = 0;
    int NLPconstructionAttempts = loadStrings("sim.txt").length-1;
    for (int q = 0; q < mainLoops; q++ ) {
      for (int h = 0; h < NLPconstructionAttempts; ) {
        if (n > retryLimit) {
          h++;
          n = 0;
        }
        n++;
        if (NLPFunction.equals("generate") == true) {
          G1 = round(random(vocab.length-1));
          G2 = round(random(vocab.length-1));
          G3 = round(random(vocab.length-1));
          G4 = round(random(vocab.length-1));
          G5 = round(random(vocab.length-1));
          G6 = round(random(vocab.length-1));
          G7 = round(random(vocab.length-1));
          G8 = round(random(vocab.length-1));
          boolean exit = false;
          for (int h2 = 0; h2 < NLPconstructionAttempts && exit == false; h2++ ) {
            String combo1 = words( split(simulationData, "\n")[h], split(res, " "), vocab[G1]);
            if (combo1.length() > 3) {
              if (h < NLPconstructionAttempts) {
                h++;
              }
              for (int h3 = 0; h3 < NLPconstructionAttempts && exit == false; h3++ ) {
                String combo2 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[G2], vocab[G3]);
                if (combo2.length() > 3) {
                  if (h < NLPconstructionAttempts) {
                    h++;
                  }
                  for (int h4 = 0; h4 < NLPconstructionAttempts && exit == false; h4++ ) {
                    String combo3 = words( split(simulationData, "\n")[h], split(res, " "), vocab[G4]);
                    if (combo3.length() > 3) {
                      if (h < NLPconstructionAttempts) {
                        h++;
                      }
                      for (int h5 = 0; h5 < NLPconstructionAttempts && exit == false; h5++ ) {
                        String combo4 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[G5], vocab[G6]);
                        if (combo4.length() > 3) {
                          if (h < NLPconstructionAttempts) {
                            h++;
                          }
                          for (int h6 = 0; h6 < NLPconstructionAttempts && exit == false; h6++ ) {
                            String combo5 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[G7], vocab[G8]);
                            if (combo5.length() > 3) {
                              if (h < NLPconstructionAttempts) {
                                h++;
                              }
                              stream += combo1 + " " + combo2 + " " + combo3 + " " +combo4 + " " +combo5 + " " + G1 + "," + G2 + "," + G3 + "," + G4 + "," + G5 + "," + G6 + "," + G7 + "," + G8 + ":\n";
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
        if (NLPFunction.equals("recall") == true) {
          String[] cat = split(ruleList, ":");
          int randCat = round(random(cat.length-2));
          boolean exit = false;
          for (int h2 = 0; h2 < NLPconstructionAttempts && exit == false; h2++ ) {
            String combo1 = words(vocab[round(random(split(vocab[int(split(cat[randCat], ",")[2])], "\n").length-1))], split(res, " "), vocab[int(split(cat[randCat], ",")[0])]);
            if (combo1.length() > 3) {
              if (h < NLPconstructionAttempts) {
                h++;
              }
              for (int h3 = 0; h3 < NLPconstructionAttempts && exit == false; h3++ ) {
                String combo2 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[int(split(cat[randCat], ",")[1])], vocab[int(split(cat[randCat], ",")[2])]);
                if (combo2.length() > 3) {
                  if (h < NLPconstructionAttempts) {
                    h++;
                  }
                  for (int h4 = 0; h4 < NLPconstructionAttempts && exit == false; h4++ ) {
                    String combo3 = words(vocab[round(random(split(vocab[int(split(cat[randCat], ",")[2])], "\n").length-1))], split(res, " "), vocab[int(split(cat[randCat], ",")[3])]);
                    if (combo3.length() > 3) {
                      if (h < NLPconstructionAttempts) {
                        h++;
                      }
                      for (int h5 = 0; h5 < NLPconstructionAttempts && exit == false; h5++ ) {
                        String combo4 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[int(split(cat[randCat], ",")[4])], vocab[int(split(cat[randCat], ",")[5])]);
                        if (combo4.length() > 3) {
                          if (h < NLPconstructionAttempts) {
                            h++;
                          }
                          for (int h6 = 0; h6 < NLPconstructionAttempts && exit == false; h6++ ) {
                            String combo5 = wordsMulti( split(simulationData, "\n")[h], split(res, " "), vocab[int(split(cat[randCat], ",")[6])], vocab[int(split(cat[randCat], ",")[7])]);
                            if (combo5.length() > 3) {
                              if (h < NLPconstructionAttempts) {
                                h++;
                              }
                              stream += combo1 + " " + combo2 + " " + combo3 + " " +combo4 + " " +combo5 + ".\n";
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
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(stream);
  outputx.close();
  exit();
}
String createSimulation()
{
  String res = join(loadStrings(mentalResource), "").replace(".", "").replace(":", "");
  String res2 = join(loadStrings(mentalResource2), "").replace(".", "").replace(":", "");
  String XS = join(loadStrings("noun.txt"), "\n");
  String XA = join(loadStrings("verb.txt"), "\n");
  int retry = 0;
  String stateChange = "", currentState = "", simulationData = "", stream = "";
  String[] function =new String[1];
  status = createWriter("status.txt");
  for (int x = 0; x < iterations; ) {
    if (x == 0) {
      simulationData = permission(split(res, " "), split(res2, " "), XA, XS);
      currentState = split(split(split(simulationData, "\n")[round(random(split(simulationData, "\n").length-1))], ":")[1], "->")[0];
      function = selectFunction(simulationData, currentState);
    }
    simulationData = permission(split(res, " "), split(res2, " "), XA, XS);
    if (simulationData.indexOf("\n") > -1) {
      function = selectFunction(simulationData, currentState);
      if (function.length-1 == 2) {
        currentState = function[1];
        if (currentState.equals("") == true) {
          simulationData = permission(split(res, " "), split(res2, " "), XA, XS);
          retry++;
        }
        if (currentState.length() > 2) {
          x++;
          status.println(function[0] + " " + currentState + " of "+ function[2] + ".");
          stream += currentState + "\n" + function[2] + "\n";
          status.flush();
        }
        if (retry >= retryLimit) {
          stateChange = permission(split(res, " "), split(res2, " "), XA, XS);
          currentState = split(split(split(stateChange, "\n")[round(random(split(stateChange, "\n").length-1))], ":")[1], "->")[0];
          function = selectFunction(stateChange, currentState);
          status.println("[done]");
          retry = 0;
        }
      }
    }
  }
  status.println("[done]");
  status.close();
  return stream;
}
String[] selectFunction(String simulationData, String currentState) {
  String state = "";
  for (int x = 0; x < functionChances; x++) {
    int match = round(random(split(simulationData, "\n").length-1));
    if (split(simulationData, "\n")[match].indexOf(":") > -1 && split(simulationData, "\n")[match].indexOf("->") > -1) {
      if (split(split(split(simulationData, "\n")[match], ":")[1], "->")[0].equals(currentState) == true && split(split(split(simulationData, "\n")[match], ":")[1], "->")[1].length() > 3) {
        state = split(split(simulationData, "\n")[match], ":")[0] + ":" + split(split(split(simulationData, "\n")[match], ":")[1], "->")[1] + ":" + split(split(split(simulationData, "\n")[match], ":")[1], "->")[0];
        break;
      }
    }
  }
  return split(state, ":");
}
String permission(String[] res, String[] res2, String objects, String transitions) {
  String state = "";
  for (int x = 0; x < realityConstructionAttempts; ) {
    int rand = round(random(res.length-7)) + 5;
    int rand2 = round(random(res2.length-7)) + 5;
    if (res[rand].equals(res2[rand2]) == true ) { // = object
      if (objects.indexOf("\n" + res[rand] + "\n") > -1 && objects.indexOf("\n" + res2[rand2] + "\n") > -1) {
        String state0 = res[rand];
        String state1 = "";
        String state2 = "";
        for (int y = -5; y < 5; y++) {
          if (transitions.indexOf("\n" + res[rand+y] + "\n") > -1 && res[rand+y].equals(state0) == false   ) {
            state1 = res[rand+y];
            break;
          }
        }
        for (int y = -5; y < 5; y++) {
          if (transitions.indexOf("\n" + res2[rand2+y] + "\n") > -1 && res2[rand2+y].equals(state0) == false && state1.equals(state2) == false ) {
            state2 = res2[rand2+y];
            break;
          }
        }
        if (state1.length() > 1 && state2.length() > 1) {
          state += state0 + ":" + state1 + "->" + state2 + "\n";
          x++;
        }
      }
    }
  }
  return state;
}
String wordsMulti(String input2, String[] res, String two, String one) {
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
  return state;
}
String words(String input, String[] res, String one) {
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
  return state;
}
