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

    private List<String> remoteNetstatResults;

    @When("^I look at \"([^\"]*)\"$")
    public void i_look_at(String instanceURL) throws Throwable {
        String[] cmd = {"/usr/bin/ssh", "-o", "StrictHostKeyChecking=no", "-i", "/Users/howarddeiner/.ssh/aws_linux.pem", "ubuntu@"+instanceURL, "sudo netstat -tulpn"};
        remoteNetstatResults = runShellCommand(cmd);
    }

    @Then("^there should be ssh connectivity$")
    public void there_should_be_ssh_connectivity() throws Throwable {
        assertThat(netstatHasSshOpen(), is(true));
    }

    @Then("^there should be smtp connectivity$")
    public void there_should_be_smtp_connectivity() throws Throwable {
        assertThat(netstatHasSmtpOpen(), is(true));
    }

    @Then("^there should be vnc connectivity$")
    public void there_should_be_vnc_connectivity() throws Throwable {
        assertThat(netstatHasVncOpen(), is(true));
    }

    @Then("^there should be guacd connectivity$")
    public void there_should_be_guacd_connectivity() throws Throwable {
        assertThat(netstatHasGuacdRunning(), is(true));
    }

    @Then("^there should be http8080 connectivity$")
    public void there_should_be_http8080_connectivity() throws Throwable {
        assertThat(netstatHasTomcatOpen(), is(true));
    }

    @Then("^there should be http8111 connectivity$")
    public void there_should_be_http8111_connectivity() throws Throwable {
        assertThat(netstatHasTeamCityOpen(), is(true));
    }

    @Then("^there should be http80 connectivity$")
    public void there_should_be_http80_connectivity() throws Throwable {
        assertThat(netstatHasHttpOpen(), is(true));
    }

    private List<String> runShellCommand(String[] command) throws IOException {
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

    private boolean netstatHasSshOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp\\s*\\d*\\s*\\d*\\s*0\\.0\\.0\\.0\\:22\\s*0\\.0\\.0\\.0\\:\\*\\s*LISTEN\\s*\\d*\\/sshd.*$");
        }
        return result;
    }

    private boolean netstatHasSmtpOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp\\s*\\d*\\s*\\d*\\s*0\\.0\\.0\\.0\\:25\\s*0\\.0\\.0\\.0\\:\\*\\s*LISTEN\\s*\\d*\\/master.*$");
        }
        return result;
    }

    private boolean netstatHasVncOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp\\s*\\d*\\s*\\d*\\s*0\\.0\\.0\\.0\\:5901\\s*0\\.0\\.0\\.0\\:\\*\\s*LISTEN\\s*\\d*\\/Xtightvnc.*$");
        }
        return result;
    }

    private boolean netstatHasGuacdRunning() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp\\s*\\d*\\s*\\d*\\s*127\\.0\\.0\\.1\\:4822\\s*0\\.0\\.0\\.0\\:\\*\\s*LISTEN\\s*\\d*\\/guacd.*$");
        }
        return result;
    }

    private boolean netstatHasTomcatOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp6\\s*\\d*\\s*\\d*\\s*:::8080\\s*:::\\*\\s*LISTEN\\s*\\d*\\/java.*$");
        }
        return result;
    }

    private boolean netstatHasTeamCityOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp6\\s*\\d*\\s*\\d*\\s*:::8111\\s*:::\\*\\s*LISTEN\\s*\\d*\\/java.*$");
        }
        return result;
    }

    private boolean netstatHasHttpOpen() {
        boolean result = false;
        for (String s : remoteNetstatResults) {
            result |= s.matches("^tcp\\s*\\d*\\s*\\d*\\s*0\\.0\\.0\\.0\\:80\\s*0\\.0\\.0\\.0\\:\\*\\s+LISTEN\\s+\\d+\\/\\S+.*$");
        }
        return result;
    }
}
