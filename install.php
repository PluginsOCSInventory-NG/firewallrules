<?php
/**
 * The following functions are used by the extension engine to generate a new table
 * for the plugin / destroy it on removal.
 */


/**
 * This function is called on installation and is used to 
 * create database schema for the plugin
 */
function extension_install_firewallrules() {
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery(
        "CREATE TABLE IF NOT EXISTS `firewallrules` (
        RULE_ID INT(11) NOT NULL AUTO_INCREMENT, 
        HARDWARE_ID INT(11) NOT NULL,
        DISPLAYNAME VARCHAR(255) NOT NULL,
        DESCRIPTION VARCHAR(255) NOT NULL,
        ENABLED VARCHAR(255) NOT NULL,
        DIRECTION VARCHAR(255) NOT NULL,
        ACTION VARCHAR(255) NOT NULL,
        PORT VARCHAR(255) NOT NULL,
        PROTOCOL VARCHAR(255) NOT NULL,
        PRIMARY KEY (RULE_ID, HARDWARE_ID)) ENGINE=INNODB;"
    );
}

/**
 * This function is called on removal and is used to 
 * destroy database schema for the plugin
 */
function extension_delete_firewallrules()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `firewallrules`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_firewallrules()
{

}

?>