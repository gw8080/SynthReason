PrintWriter outputx;
String mentalResource = "emotion.txt";
String NLP_Resource = "exp.txt";
int retryLimit = 50;
int mainLoop = 10;
int accuracyValue = 20;
int comboSearchValue = 10000;
void setup()
{
  String[] simulationData = split(join(loadStrings(mentalResource), ""), ".");
  String[] res = split(join(loadStrings(NLP_Resource), ""), " ");
  String resFull = join(loadStrings(mentalResource), "");
  String output = "";
  for (int h2 = 0; h2 < mainLoop; h2++ ) {
    int count = 0;
    int x = round(random(simulationData.length-1));
    int NLPconstructionAttempts = split(simulationData[x], " ").length-1;
    for (int h = 0; h < NLPconstructionAttempts; count++) {
      String combo = words(split(simulationData[x], " ")[h], res);
      if (output.length() == 0) {
        output = combo + " ";
        h++;
      }
      if (split(output, " ").length-1 > 1 && split(combo, " ").length-1 > 1) {
        if (resFull.indexOf(split(combo, " ")[1]) > -1) {
          int contextCount = 0;
          for (int y = 0; y < accuracyValue; y++) {
            if (resFull.indexOf(split(output, " ")[round(random(split(output, " ").length-1))]) > -1) {
              contextCount++;
            }
            if (contextCount == accuracyValue) {
              String process = "";
              String[] test = split(output, " ");
              for (int a = test.length-2; a > 0; a--) {
                process += test[a] + " ";
              }
              if (resFull.indexOf(split(process, " ")[split(process, " ").length-2] + " " + split(combo, " ")[0]) > -1 && resFull.indexOf(split(process, " ")[split(process, " ").length-2] + " " + combo) == -1 ) {
                output = process + combo + " ";
                h++;
              }
            }
          }
        }
      }
      if (count > retryLimit*NLPconstructionAttempts) {
        h++;
        count = 0;
      }
    }
  }
  String output2 = "";
  for (int b = split(output, " ").length/2; b > 0; b-- ) {
    output2 += split(output, " ")[b] + " ";
  }
  outputx = createWriter("output.txt");
  outputx.println(output2);
  outputx.close();
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 1; x < comboSearchValue; x++ ) {
    int rand = round(random(res.length-4))+2;
    if ( res[rand].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      if (res[rand-1].length() > 3) {
        break;
      }
    }
  }
  return state;
}
