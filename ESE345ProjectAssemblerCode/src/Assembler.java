import java.io.*;
import java.util.ArrayList;
import java.util.Hashtable;

public class Assembler {
    public static void main(String[] args)
    {
        Hashtable<String,String> conversion = new Hashtable<>();
        //load immediate
        conversion.put("LI","0");

        //hextoBin Representation
        conversion.put("0","0000");
        conversion.put("1","0001");
        conversion.put("2","0010");
        conversion.put("3","0011");
        conversion.put("4","0100");
        conversion.put("5","0101");
        conversion.put("6","0110");
        conversion.put("7","1110");
        conversion.put("8","1000");
        conversion.put("9","1001");
        conversion.put("A","1010");
        conversion.put("B","1011");
        conversion.put("C","1100");
        conversion.put("D","1101");
        conversion.put("E","1110");
        conversion.put("F","1111");
        //load index
        conversion.put("LI0","000");
        conversion.put("LI1","001");
        conversion.put("LI2","010");
        conversion.put("LI3","011");
        conversion.put("LI4","100");
        conversion.put("LI5","101");
        conversion.put("LI6","110");
        conversion.put("LI7","111");

        //Sets the Register values in binary into hashtable
        for(int i = 0; i < 32; i++)
        {
            String binary = Integer.toBinaryString(i);
            if (binary.length() < 5)
            {
                int length = binary.length();
                for (int j = 1; j <= 5 - length; j++)
                {
                    binary = "0" + binary;
                }
            }
            //System.out.println(binary);
            conversion.put("R" + i, binary);
        }

        //R4 Instructions
        conversion.put("SIMALS","10000"); //Signed Integer Multiply-Add Low with Saturation
        conversion.put("SIMAHS","10001"); //Signed Integer Multiply-Add High with Saturation
        conversion.put("SIMSLS","10010"); //Signed Integer Multiply-Subtract Low with Saturation
        conversion.put("SIMSHS","10011"); //Signed Integer Multiply-Subtract High with Saturation
        conversion.put("SLIMALS","10100"); //Signed Long Integer Multiply-Add Low with Saturation
        conversion.put("SLIMAHS","10101"); //Signed Long Integer Multiple-Add High with Saturation
        conversion.put("SLIMSLS","10110"); //Signed Long Integer Multiply-Subtract Low with Saturation
        conversion.put("SLIMSHS","10111"); //Signed Long Integer Multiply-Subtact High with Saturation


        //R3 Instructions
        conversion.put("NOP","1100000000");
        conversion.put("AU","1100000001");
        conversion.put("ABSDB","1100000010");
        conversion.put("AHU","1100000011");
        conversion.put("AHS","1100000100");
        conversion.put("AND","1100000101");
        conversion.put("BCW","1100000110");
        conversion.put("MAXWS","1100000111");
        conversion.put("MINWS","1100001000");
        conversion.put("MLHU","1100001001");
        conversion.put("MLHCU","1100001010");
        conversion.put("OR","1100001011");
        conversion.put("PCNTW","1100001100");
        conversion.put("ROTW","1100001101");
        conversion.put("SFHS","1100001110");
        conversion.put("SFW","1100001111");

        try {
            //Reads from Assembly File
            FileInputStream AssemblyFile = new FileInputStream("C:\\Users\\richard ma\\Desktop\\ESE345PROJECT2021\\ESE345ProjectALU\\ESE345ProjectAssemblerCode\\src\\Assembler.txt");
            InputStreamReader reader = new InputStreamReader(AssemblyFile);
            BufferedReader buffReader = new BufferedReader(reader);

            //Writes into a new file called Machine_Code
            File MachineCode = new File("C:\\Users\\richard ma\\Desktop\\ESE345PROJECT2021\\ESE345ProjectALU\\ESE345ProjectAssemblerCode\\src\\Machine_Code.txt");
            BufferedWriter writer = new BufferedWriter(new FileWriter(MachineCode));

            //Converting Assembly Instruction into Machine Code
            ArrayList<String> AssemblyInstr = new ArrayList<String>();

            //Reads Assembly Instruction and inputs into ArrayList
            String read = buffReader.readLine().toUpperCase();
            String result = null;
            String hexResult = "";
            String temp = "";
            String hexBinValue = null;
            String combined = "";
            while(read != null)
            {
                if(read.equals(""))
                {
                    read = buffReader.readLine().toUpperCase();
                    continue;
                }
                AssemblyInstr.add(read);
                read = buffReader.readLine();
            }
            for(int i = 0; i < AssemblyInstr.size();i++)
            {
                combined = "";
                System.out.println(AssemblyInstr.get(i));
                String[] arrayOfInstructions = AssemblyInstr.get(i).split(" ");
                for(int k = 0; k < arrayOfInstructions.length; k++)
                {
                    System.out.println(arrayOfInstructions[k]);
                    result = conversion.get(arrayOfInstructions[k]);
                    if(arrayOfInstructions[k].charAt(0) == 'X')
                    {
                        for(int j = 1; j < arrayOfInstructions[k].length();j++)
                        {
                            String hex = arrayOfInstructions[k].substring(j,j+1);
                            temp = conversion.get(hex);
                            System.out.println(temp);
                            hexResult += temp;
                        }
                    }
                    else
                    {
                        temp = conversion.get(arrayOfInstructions[k]);

                    }
                    if(arrayOfInstructions[k].charAt(0) == 'X')
                    {
                        result = hexResult;
                    }
                    System.out.println("This is the result of the machine code of " +
                            arrayOfInstructions[k] + ": " + result);
                    combined += result;
                }
                //combined += result;
                //combined += hexBinValue;
                System.out.println(combined + " is the concatenation and full machine code for the instruction");
                writer.write(combined);
                writer.newLine();
            }
            writer.close();
        } catch(IOException ex) {
            ex.printStackTrace();
        }
    }
}
