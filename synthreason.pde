PrintWriter outputx;
PrintWriter status;
String mentalResource = "reason.txt";
int mainLoop = 1000; // how many attempts to generate a sample
int retryLimit = 1000; // how many attempts to generate a sample
int comboSearchValue = 10000000; // combo search value
int theoreticalMin = 1000;
int precision = 5;
String txt = "";
void setup()
{
  String[] res = split(eliminateGarbage(mentalResource).replace(".", ". ").toLowerCase(), " ");
  String[] resSegment = split(eliminateGarbage(mentalResource).replace(".", ". ").toLowerCase(), ".");
  for (int y = 0; y < retryLimit; y++ ) {
    int rand = round(random(res.length-1));
    String process = words(res[rand], res) + " ";
    for (int x = 0; x < mainLoop; x++ ) {
      String combo = words(res[rand], res);
      for (int z = 0; z != precision+1; z++) {
        if (controlDivergence(split(combo, " ")[round(random(split(combo, " ").length-1))], split(process, " ")[round(random(split(process, " ").length-2))], resSegment) == false) {
          break;
        }
        if (controlDivergence(split(combo, " ")[round(random(split(combo, " ").length-1))], split(process, " ")[round(random(split(process, " ").length-2))], resSegment) == true) {
          if (z == precision) {
            process += words(split(words(split(words(split(words(split(words(split(words(split(words(split(process, " ")[round(random(split(process, " ").length-1))], res), " ")[round(random(2))], res), " ")[round(random(2))], res), " ")[round(random(2))], res), " ")[round(random(2))], res), " ")[round(random(2))], res), " ")[round(random(2))], res) + " ";
            rand = round(random(res.length-1));
          }
        }
      }
    }
    if (process.length() > theoreticalMin) {
      outputx = createWriter("output.txt");
      outputx.println("SynthReason output:\n\n" + "Mental resource used: " + mentalResource + "\n");
      outputx.println(process);
      outputx.println();
      outputx.close();
      break;
    }
  }
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 0; x != comboSearchValue+1; x++ ) {
    int rand = round(random(res.length-4))+1;
    if ( res[rand].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      break;
    }
    if (x == comboSearchValue) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      break;
    }
  }
  return state;
}
String eliminateGarbage(String resource)
{
  String proc =  join(loadStrings(resource), "");
  String[] eliminate = {"-", "=", "[", "]", ";", ":", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate.length; k++) {
    proc = proc.replace(eliminate[k], "");
  }
  return proc;
}
boolean controlDivergence(String object, String interaction, String[] resource) {
  boolean state = false;
  int objectCount = 0, objectReductionCount = 0;
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") > -1) {
      objectCount++;
    }
  }
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") == -1) {
      objectReductionCount++;
    }
  }
  if ( objectCount < objectReductionCount) {
    state = true;
  }
  return state;
}
