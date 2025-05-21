/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author PAUL
 */
public class generar {
    
    public static void main(String[] args) {
        String pass = "41424344";
        String hash = BCrypt.hashpw(pass, BCrypt.gensalt());
        System.out.println(hash);
    }
}
