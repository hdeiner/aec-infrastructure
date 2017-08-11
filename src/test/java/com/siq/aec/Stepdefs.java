package com.siq.aec;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class Stepdefs {

    private String machineName;
    private List<String> remoteNetstatResults;

    @When("^I look at \"([^\"]*)\"$")
    public void i_look_at(String instanceURL) throws Throwable {
        machineName = instanceURL;
        String[] cmd = {"/usr/bin/ssh", "-o", "StrictHostKeyChecking=no", "ubuntu@"+instanceURL, "sudo netstat -tulpn"};
        remoteNetstatResults = runShellCommand(cmd);
    }

    @Then("^it should be running \"([^\"]*)\" on port \"([^\"]*)\"$")
    public void it_should_be_running_on_port(String programName, String portNumber) throws Throwable {
        assertThat(isProgramRunningOnPort(programName, portNumber), is(true));
    }

    @Then("^port \"([^\"]*)\" should be open$")
    public void port_should_be_open(String portNumber) throws Throwable {
        assertThat(isPortOpen(portNumber), is(true));
    }

    private List<String> runShellCommand(String[] command) throws IOException {
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

    private boolean isProgramRunningOnPort(String programName, String portNumber) {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            String regEx = "^tcp\\d*\\s*\\d*\\s*\\d*\\s*[0127\\.\\:]+" + portNumber + "\\s*[0\\.\\:]+\\*\\s*LISTEN\\s*\\d+\\/" + programName + ".*$";
            result |= s.matches(regEx);
        }
        return result;
    }

    private boolean isPortOpen(String portNumber) throws IOException {
        String[] cmd = {"nmap", machineName, "-p", portNumber};
        List<String> nmapResults = runShellCommand(cmd);
        boolean result = false;
        for (String s : nmapResults) {
            String regEx = "^" + portNumber + ".*open.*$";
            result |= s.matches(regEx);
        }
        return result;
    }
}
