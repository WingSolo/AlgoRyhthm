package common;

import java.io.File;
import java.io.IOException;

public class Ana_python {
	
	public static void main(String[] args) {
        File batFile = new File("C:\\python\\test.bat");
        ProcessBuilder processBuilder = new ProcessBuilder(batFile.getAbsolutePath());
        processBuilder.directory(new File("C:\\python\\"));

        try {
            Process process = processBuilder.start();

            new Thread(() -> {
                try (var reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }).start();

            int exitCode = process.waitFor();
            System.out.println("Process exited with code: " + exitCode);

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    
}
