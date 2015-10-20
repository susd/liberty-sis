module Ischool
  module FormMaps

    module TkCard
      def tk_card_map
        {
          'language-arts.1.effort'            => 'la_e.0',
          'language-arts.2.effort'            => 'la_e.1',
          'language-arts.3.effort'            => 'la_e.2',

          'phonemic-awareness.1.score'        => ['la1.0.0', 'la1.0.1', 'la1.0.2'],
          'phonemic-awareness.2.score'        => ['la2.0.0', 'la2.0.1', 'la2.0.2'],
          'phonemic-awareness.3.score'        => ['la3.0.0', 'la3.0.1', 'la3.0.2'],

          'letter-names-sounds.1.score'       => ['la1.1.0', 'la1.1.1', 'la1.1.2'],
          'letter-names-sounds.2.score'       => ['la2.1.0', 'la2.1.1', 'la2.1.2'],
          'letter-names-sounds.3.score'       => ['la3.1.0', 'la3.1.1', 'la3.1.2'],

          'comprehension.1.score'             => ['la1.2.0', 'la1.2.1', 'la1.2.2'],
          'comprehension.2.score'             => ['la2.2.0', 'la2.2.1', 'la2.2.2'],
          'comprehension.3.score'             => ['la3.2.0', 'la3.2.1', 'la3.2.2'],

          'listening.1.score'                 => ['la1.3.0', 'la1.3.1', 'la1.3.2'],
          'listening.2.score'                 => ['la2.3.0', 'la2.3.1', 'la2.3.2'],
          'listening.3.score'                 => ['la3.3.0', 'la3.3.1', 'la3.3.2'],

          'speaking.1.score'                  => ['la1.4.0', 'la1.4.1', 'la1.4.2'],
          'speaking.2.score'                  => ['la2.4.0', 'la2.4.1', 'la2.4.2'],
          'speaking.3.score'                  => ['la3.4.0', 'la3.4.1', 'la3.4.2'],

          'mathematics.1.effort'              => ['m_e.0'],
          'mathematics.2.effort'              => ['m_e.1'],
          'mathematics.3.effort'              => ['m_e.2'],

          'number-sense.1.score'              => ['m1.0.0', 'm1.0.1', 'm1.0.2'],
          'number-sense.2.score'              => ['m1.0.3', 'm1.0.4', 'm1.0.5'],
          'number-sense.3.score'              => ['m1.0.6', 'm1.0.7', 'm1.0.8'],

          'data-and-measurement.1.score'      => ['m1.1.0', 'm1.1.1', 'm1.1.2'],
          'data-and-measurement.2.score'      => ['m1.1.3', 'm1.1.4', 'm1.1.5'],
          'data-and-measurement.3.score'      => ['m1.1.6', 'm1.1.7', 'm1.1.8'],

          'geometry.1.score'                  => ['m1.2.0', 'm1.2.1', 'm1.2.2'],
          'geometry.2.score'                  => ['m1.2.3', 'm1.2.4', 'm1.2.5'],
          'geometry.3.score'                  => ['m1.2.6', 'm1.2.7', 'm1.2.8'],

          'social-emotional-development.1.effort' => ['sd_e.0'],
          'social-emotional-development.2.effort' => ['sd_e.1'],
          'social-emotional-development.3.effort' => ['sd_e.2'],

          'self-control.1.score'              => ['sd1.0.0', 'sd1.0.1', 'sd1.0.2'],
          'self-control.2.score'              => ['sd2.0.0', 'sd2.0.1', 'sd2.0.2'],
          'self-control.3.score'              => ['sd3.0.0', 'sd3.0.1', 'sd3.0.2'],

          'cooperation-with-others.1.score'   => ['sd1.1.0', 'sd1.1.1', 'sd1.1.2'],
          'cooperation-with-others.2.score'   => ['sd2.1.0', 'sd2.1.1', 'sd2.1.2'],
          'cooperation-with-others.3.score'   => ['sd3.1.0', 'sd3.1.1', 'sd3.1.2'],

          'personal-care-routines.1.score'    => ['sd1.2.0', 'sd1.2.1', 'sd1.2.2'],
          'personal-care-routines.2.score'    => ['sd2.2.0', 'sd2.2.1', 'sd2.2.2'],
          'personal-care-routines.3.score'    => ['sd3.2.0', 'sd3.2.1', 'sd3.2.2'],

          'relationships-with-peers.1.score'  => ['sd1.3.0', 'sd1.3.1', 'sd1.3.2'],
          'relationships-with-peers.2.score'  => ['sd2.3.0', 'sd2.3.1', 'sd2.3.2'],
          'relationships-with-peers.3.score'  => ['sd3.3.0', 'sd3.3.1', 'sd3.3.2'],

          'physical-development.1.effort'     => ['pd_e.0'],
          'physical-development.2.effort'     => ['pd_e.1'],
          'physical-development.3.effort'     => ['pd_e.2'],

          'penmanship.1.score'                => ['pd1.0.0', 'pd1.0.1', 'pd1.0.2'],
          'penmanship.2.score'                => ['pd2.0.0', 'pd2.0.1', 'pd2.0.2'],
          'penmanship.3.score'                => ['pd3.0.0', 'pd3.0.1', 'pd3.0.2'],

          'large-motor-skills.1.score'        => ['pd1.1.0', 'pd1.1.1', 'pd1.1.2'],
          'large-motor-skills.2.score'        => ['pd2.1.0', 'pd2.1.1', 'pd2.1.2'],
          'large-motor-skills.3.score'        => ['pd3.1.0', 'pd3.1.1', 'pd3.1.2'],

          'small-motor-skills.1.score'        => ['pd1.2.0', 'pd1.2.1', 'pd1.2.2'],
          'small-motor-skills.2.score'        => ['pd2.2.0', 'pd2.2.1', 'pd2.2.2'],
          'small-motor-skills.3.score'        => ['pd3.2.0', 'pd3.2.1', 'pd3.2.2'],

          'social-science.1.score'            => ['ss1.0', 'ss1.1', 'ss1.2'],
          'social-science.2.score'            => ['ss2.0', 'ss2.1', 'ss2.2'],
          'social-science.3.score'            => ['ss3.0', 'ss3.1', 'ss3.2'],

          'social-science.1.effort'           => ['ss_e.0'],
          'social-science.2.effort'           => ['ss_e.1'],
          'social-science.3.effort'           => ['ss_e.2'],

          'science-health.1.effort'           => ['sma1.0'],
          'science-health.2.effort'           => ['sma2.0'],
          'science-health.3.effort'           => ['sma3.0'],

          'music.1.effort'                    => ['sma1.1'],
          'music.2.effort'                    => ['sma2.1'],
          'music.3.effort'                    => ['sma3.1'],

          'art.1.effort'                      => ['sma1.2'],
          'art.2.effort'                      => ['sma2.2'],
          'art.3.effort'                      => ['sma3.2'],

          'listens-and-follows-instructions.1.effort' => 'wsh.0.0',
          'listens-and-follows-instructions.2.effort' => 'wsh.0.1',
          'listens-and-follows-instructions.3.effort' => 'wsh.0.2',

          'stays-on-task.1.effort'              => 'wsh.1.0',
          'stays-on-task.2.effort'              => 'wsh.1.1',
          'stays-on-task.3.effort'              => 'wsh.1.2',

          'completes-work-accurately.1.effort'  => 'wsh.2.0',
          'completes-work-accurately.2.effort'  => 'wsh.2.1',
          'completes-work-accurately.3.effort'  => 'wsh.2.2',

          'completes-work-on-time.1.effort'     => 'wsh.3.0',
          'completes-work-on-time.2.effort'     => 'wsh.3.1',
          'completes-work-on-time.3.effort'     => 'wsh.3.2',

          'uses-materials-correctly.1.effort'   => 'wsh.4.0',
          'uses-materials-correctly.2.effort'   => 'wsh.4.1',
          'uses-materials-correctly.3.effort'   => 'wsh.4.2',

          'completes-work-neatly.1.effort'      => 'wsh.5.0',
          'completes-work-neatly.2.effort'      => 'wsh.5.1',
          'completes-work-neatly.3.effort'      => 'wsh.5.2',

          'participates-in-classroom-activities.1.effort' => 'wsh.6.0',
          'participates-in-classroom-activities.2.effort' => 'wsh.6.1',
          'participates-in-classroom-activities.3.effort' => 'wsh.6.2',

          'respects-authority.1.effort'       => 'cit.0.0',
          'respects-authority.2.effort'       => 'cit.0.1',
          'respects-authority.3.effort'       => 'cit.0.2',

          'respects-others-rights-property.1.effort' => 'cit.1.0',
          'respects-others-rights-property.2.effort' => 'cit.1.1',
          'respects-others-rights-property.3.effort' => 'cit.1.2',

          'observes-rules.1.effort'           => 'cit.2.0',
          'observes-rules.2.effort'           => 'cit.2.1',
          'observes-rules.3.effort'           => 'cit.2.2',

          'accepts-responsibility.1.effort'   => 'cit.3.0',
          'accepts-responsibility.2.effort'   => 'cit.3.1',
          'accepts-responsibility.3.effort'   => 'cit.3.2'
        }
      end

      def value_map
        tk_card_map
      end

      def desired_fields
        value_map.values.flatten.sort
      end

      def attendance_map
        {
          'att.0.0' => 'absences.1',
          'att.0.1' => 'absences.2',
          'att.0.2' => 'absences.3',

          'att.1.0' => 'tardies.1',
          'att.1.1' => 'tardies.2',
          'att.1.2' => 'tardies.3'
        }
      end
    end

  end
end
