package com.siq.aec;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

public class CreateFeatureFiles {

    public static void main(String[] args) throws IOException {
        List<String> aecStudentInstances;
        List<String> aecJenkinsInstances;

        String studentTemplateFile = "InfrastructureStudent.feature.template";
        String studentFeatureFile = "src/test/java/com/siq/aec/InfrastructureStudent.feature";
        String jenkinsTemplateFile = "InfrastructureJenkins.feature.template";
        String jenkinsFeatureFile = "src/test/java/com/siq/aec/InfrastructureJenkins.feature";

        String[] cmd1 = {"/usr/local/bin/terraform", "output", "student_addresses"};
        aecStudentInstances = runShellCommand(cmd1);

        Files.copy(Paths.get(studentTemplateFile), new FileOutputStream(studentFeatureFile));
        for (String s : aecStudentInstances) {
            if (s.endsWith(",")) {
                s = s.substring(0,s.length()-1);
            }
            s = "|" + s + "|" + System.getProperty("line.separator");
            Files.write(Paths.get(studentFeatureFile), s.getBytes(), StandardOpenOption.APPEND);
        }
        String[] cmd2 = {"/usr/local/bin/terraform", "output", "jenkins_address"};
        aecJenkinsInstances = runShellCommand(cmd2);

        Files.copy(Paths.get(jenkinsTemplateFile), new FileOutputStream(jenkinsFeatureFile));
        for (String s : aecJenkinsInstances) {
            if (s.endsWith(",")) {
                s = s.substring(0,s.length()-1);
            }
            s = "|" + s + "|" + System.getProperty("line.separator");
            Files.write(Paths.get(jenkinsFeatureFile), s.getBytes(), StandardOpenOption.APPEND);
        }
    }

    private static List<String> runShellCommand(String[] command) throws IOException {
        List<String> output = new ArrayList<String>();

        Process p = Runtime.getRuntime().exec(command);

        BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

        BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));

        String s = null;
        while ((s = stdInput.readLine()) != null) {
//            System.out.println(s);
            output.add(s);
        }

        while ((s = stdError.readLine()) != null) {
            System.out.println("!!! " + s);
        }

        return output;
    }

}
