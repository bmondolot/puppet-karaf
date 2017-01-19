# PRIVATE CLASS - do not use directly
#
# The karaf default configuration settings.
class karaf::params {

  # Default install dir.
  $rootdir            = '/opt'

  # Default karaf version to install
  $version            = '4.0.8'

  # Value could be 'web' or 'file'. Choose if karaf should be installed from web
  # or from file. If file, please provide zip archive in files directory.
  $install_from       = 'web'

  # url to download karaf in case install is done from the web
  $karaf_zip_url = "http://mirrors.ircam.fr/pub/apache/karaf/${version}/apache-karaf-${version}.zip"

  # name of zip file to be placed in files directory in case install is done from file
  $karaf_file_name    = "apache-karaf-${version}"

  # --------------------------------
  # Service variables.
  # --------------------------------
  $service_name       = 'karaf'
  $service_user_name  = 'karaf'
  $service_user_id    = 500
  $service_group_name = 'karaf'
  $service_group_id   = 500

  # --------------------------------
  # Java home
  # --------------------------------
  $java_home          = '/usr/lib/jvm/java-1.8.0-openjdk'

  # --------------------------------
  # Environnment variables
  # --------------------------------
  $default_env_vars   = []

  # --------------------------------
  # Karaf custom properties.
  # --------------------------------
  $karaf_custom_properties = []

  # --------------------------------
  # Karaf system properties.
  # --------------------------------
  $karaf_http_port    = 8181
  $karaf_ssh_host     = '0.0.0.0'
  $karaf_ssh_port     = 8101
  $karaf_ssh_user     = 'karaf'

  # --------------------------------
  # Logging
  # --------------------------------
  $file_karaf_logging  = "puppet:///modules/karaf/karaf/etc/org.ops4j.pax.logging.cfg"

  # --------------------------------
  # Maven settings
  # --------------------------------
  $file_maven_settings = "puppet:///modules/karaf/maven/settings.xml"
  $mvn_repositories = [
    "http://repo1.maven.org/maven2@id=central",
    "http://repository.springsource.com/maven/bundles/release@id=spring.ebr.release",
    "http://repository.springsource.com/maven/bundles/external@id=spring.ebr.external",
    "http://zodiac.springsource.com/maven/bundles/release@id=gemini",
    "http://repository.apache.org/content/groups/snapshots-group@id=apache@snapshots@noreleases",
    "https://oss.sonatype.org/content/repositories/snapshots@id=sonatype.snapshots.deploy@snapshots@noreleases",
    "https://oss.sonatype.org/content/repositories/ops4j-snapshots@id=ops4j.sonatype.snapshots.deploy@snapshots@noreleases",
    "http://repository.springsource.com/maven/bundles/external@id=spring-ebr-repository@snapshots@noreleases"
  ]

  # ----------------------------------
  # Karaf Features and repo management.
  # ----------------------------------
  $karaf_additional_repos   = []
  $karaf_startup_feature_repos = []
  $karaf_startup_feature_boots = []

}