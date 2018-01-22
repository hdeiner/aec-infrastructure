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
        String studentTemplateFile = "InfrastructureStudent.feature.template";
        String studentFeatureFile = "src/test/java/com/siq/aec/InfrastructureStudent.feature";
        String bambooTemplateFile = "InfrastructureBamboo.feature.template";
        String bambooFeatureFile = "src/test/java/com/siq/aec/InfrastructureBamboo.feature";
        String teamcityTemplateFile = "InfrastructureTeamCity.feature.template";
        String teamcityFeatureFile = "src/test/java/com/siq/aec/InfrastructureTeamCity.feature";
        String jenkinsTemplateFile = "InfrastructureJenkins.feature.template";
        String jenkinsFeatureFile = "src/test/java/com/siq/aec/InfrastructureJenkins.feature";
        String gitlabTemplateFile = "InfrastructureGitlab.feature.template";
        String gitlabFeatureFile = "src/test/java/com/siq/aec/InfrastructureGitlab.feature";

        writeFeatureFileFromTemplate(studentTemplateFile, studentFeatureFile, "student_addresses");
        writeFeatureFileFromTemplate(bambooTemplateFile, bambooFeatureFile, "bamboo_address");
        writeFeatureFileFromTemplate(teamcityTemplateFile, teamcityFeatureFile, "teamcity_address");
        writeFeatureFileFromTemplate(jenkinsTemplateFile, jenkinsFeatureFile, "jenkins_address");
        writeFeatureFileFromTemplate(gitlabTemplateFile, gitlabFeatureFile, "gitlab_address");
    }

    private static void writeFeatureFileFromTemplate(String templateFile, String featureFile, String whichAddresses) throws IOException {
        String[] cmd = {"terraform", "output", whichAddresses};
        List<String> instances = runShellCommand(cmd);

        Files.copy(Paths.get(templateFile), new FileOutputStream(featureFile));
        for (String s : instances) {
            if (s.endsWith(",")) {
                s = s.substring(0,s.length()-1);
            }
            s = "|" + s + "|" + System.getProperty("line.separator");
            Files.write(Paths.get(featureFile), s.getBytes(), StandardOpenOption.APPEND);
        }
    }

    private static List<String> runShellCommand(String[] command) throws IOException {
        List<String> output = new ArrayList<>();

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
