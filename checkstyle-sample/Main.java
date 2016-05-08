import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        
        System.out.println("Hello Luke!");

        Scanner input = new Scanner(System.in);

        int numStudents = Integer.parseInt(input.nextLine());

        System.out.println("Entering the loop!");

        String[] firstNames = new String[numStudents];
        String[] lastNames  = new String[numStudents];
        int[]    grades     = new int[numStudents];

        for(int counter = 0; counter < numStudents; counter++) {
            System.out.println(counter);
            firstNames[counter]   = input.nextLine();
            lastNames[counter]    = input.nextLine();
            grades[counter]       = Integer.parseInt(input.nextLine());
        }

        for(int i = 0; i < numStudents; i++) {
            System.out.printf("%10s", firstNames[i]);
            System.out.print("\t");
            System.out.printf("%10s", lastNames[i]);
            System.out.printf("\t");
            System.out.printf("%10s", grades[i]);
            System.out.print("\n");
        }

        int maxIndex = 0;
        for(int i = 0; i < numStudents; i++) {
            if(grades[i] > grades[maxIndex]) {
                maxIndex = i;
            }
        }

        System.out.println();

        System.out.printf("%10s", firstNames[maxIndex]);
        System.out.print("\t");
        System.out.printf("%10s", lastNames[maxIndex]);
        System.out.printf("\t");
        System.out.printf("%10s", grades[maxIndex]);
        System.out.print("\n");
    }
}
