PrintWriter outputx;
int realityConstructionAttempts = 20000;
int functionChances = 10000;
int iterations = 3;

void setup()
{
  String res = join(loadStrings("exp.txt"), "").replace(".", "").replace(":", "");
  String res2 = join(loadStrings("uber.txt"), "").replace(".", "").replace(":", "");
  String XS = join(loadStrings("noun.txt"), "\n");
  String XA = join(loadStrings("verb.txt"), "\n");
  String stateChange = "", currentState = "", function = "";
  outputx = createWriter("output.txt");
  for (int x = 0; x < iterations; ) {
    if (x == 0) {
      stateChange = permission(split(res, " "), split(res2, " "), XA, XS);
      currentState = split(split(split(stateChange, "\n")[round(random(split(stateChange, "\n").length-1))], ":")[1], "->")[0];
      function = selectFunction(stateChange, currentState);
    }
    String simulationData = permission(split(res, " "), split(res2, " "), XA, XS);
    if (simulationData.indexOf("\n") > -1) {
      x++;
      function = selectFunction(simulationData, currentState);
      currentState = function;
      outputx.println(currentState);
      outputx.flush();
    }
  }
  outputx.println("[done]");
  outputx.close();
  exit();
}
String selectFunction(String simulationData, String currentState) {

  String state = "";
  for (int x = 0; x < functionChances; x++) {
    int match = round(random(split(simulationData, "\n").length-1));
    if (split(simulationData, "\n")[match].indexOf(":") > -1 && split(simulationData, "\n")[match].indexOf("->") > -1) {
      if (split(split(split(simulationData, "\n")[match], ":")[1], "->")[0].equals(currentState) == true) {
        state = split(split(split(simulationData, "\n")[match], ":")[1], "->")[1];
        break;
      }
    }
  }
  return state;
}
String[] workingMemory(String res, String res2, String function) {
  String[] resA = split(res, ".");
  String[] res2A = split(res2, ".");
  String mem = "";
  for (int x = 0; x < resA.length-1; x++) {
    if (resA[x].indexOf(function) > -1) {
      mem += resA[x] + ".";
    }
  }
  mem += ":::::";
  for (int x = 0; x < res2A.length-1; x++) {
    if (res2A[x].indexOf(function) > -1) {
      mem += res2A[x] + ".";
    }
  }
  String[] state = split(mem, ":::::");
  return state;
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
