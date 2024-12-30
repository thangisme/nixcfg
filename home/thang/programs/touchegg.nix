{ ... }:
{
  home.file.".config/touchegg/touchegg.conf".text = ''
    <touchégg>
      <settings>
        <property name="animation_delay">150</property>
        <property name="action_execute_threshold">20</property>
        <property name="color">auto</property>
        <property name="borderColor">auto</property>
      </settings>
      <application name="All">
        <gesture type="SWIPE" fingers="3" direction="UP">
          <action type="RUN_COMMAND">
            <command>~/.local/bin/karouselctl grid-scroll-left</command>
            <repeat>true</repeat>
            <animation>NONE</animation>
            <decreaseCommand>~/bin/karouselctl grid-scroll-right</decreaseCommand>
          </action>
        </gesture>
        <gesture type="SWIPE" fingers="3" direction="DOWN">
          <action type="RUN_COMMAND">
            <command>~/.local/bin/karouselctl grid-scroll-right</command>
            <repeat>true</repeat>
            <animation>NONE</animation>
            <decreaseCommand>~/bin/karouselctl grid-scroll-left</decreaseCommand>
          </action>
        </gesture>
      </application>
    </touchégg>
  '';
}
