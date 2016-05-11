<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://schema.omg.org/spec/UML/2.0"
                xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">

    <xsl:output method="xml" indent="yes"/>


    <xsl:template match="/">
        <beans>
            <xsl:for-each select="xmi:XMI/uml:Model">
                <xsl:apply-templates select="ownedMember[@xmi:type='uml:Class']"/>
            </xsl:for-each>

            <xsl:for-each select="xmi:XMI/uml:Model/ownedMember[@xmi:type='uml:Class']">
                <xsl:apply-templates select="ownedAttribute" mode="beans"/>
            </xsl:for-each>
        </beans>
    </xsl:template>

    <xsl:template match="ownedMember">

        <xsl:element name="bean">

            <xsl:attribute name="id">
                <xsl:value-of
                        select="concat(translate(substring(@name, 1, 1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), substring(@name, 2))"/>

            </xsl:attribute>

            <xsl:attribute name="class">
                <xsl:value-of
                        select="@name"/>
            </xsl:attribute>

            <xsl:for-each select="ownedAttribute">
                <xsl:apply-templates select="." mode="properties"/>
            </xsl:for-each>

        </xsl:element>
    </xsl:template>

    <xsl:template match="ownedAttribute" mode="properties">
        <xsl:element name="property">
            <xsl:attribute name="name">
                <xsl:value-of
                        select="concat(translate(substring(@name, 1, 1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), substring(@name, 2))"/>

            </xsl:attribute>
            <xsl:attribute name="bean">
                <xsl:value-of
                        select="concat(translate(substring(@name, 1, 1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), substring(@name, 2))"/>

            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ownedAttribute" mode="beans">
        <xsl:element name="bean">

            <xsl:attribute name="id">
                <xsl:value-of
                        select="concat(translate(substring(@name, 1, 1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), substring(@name, 2))"/>

            </xsl:attribute>

            <xsl:attribute name="class">
                <xsl:value-of
                        select="@name"/>
            </xsl:attribute>

            <xsl:variable name="id" select="@xmi:id"/>

            <!--<xsl:variable name="matching-items" select="/xmi:XMI/uml:Model/ownedMember/ownedMember[end/@role=$id]" />-->

            <xsl:for-each select="/xmi:XMI/uml:Model/ownedMember/ownedMember[end/@role=$id]">
                <xsl:attribute name="link">
                    <xsl:value-of
                            select="@name"/>
                </xsl:attribute>
            </xsl:for-each>

        </xsl:element>
    </xsl:template>

</xsl:stylesheet>