module Ischool
  module FormMaps

    module PrimaryCard
      def primary_card_map
        {
          'reading.1.effort'            => ['a.7'],
          'reading.2.effort'            => ['a.9'],
          'reading.3.effort'            => ['a.11'],

          'reading.1.level'             => ['a.6'],
          'reading.2.level'             => ['a.8'],
          'reading.3.level'             => ['a.10'],

          'word-attack-skills.1.score'  => ['b.1', 'b.2', 'b.3'],
          'word-attack-skills.2.score'  => ['b.43', 'b.44', 'b.45'],
          'word-attack-skills.3.score'  => ['b.85', 'b.86', 'b.87'],

          'comprehension.1.score'       => ['b.4', 'b.5', 'b.6'],
          'comprehension.2.score'       => ['b.46', 'b.47', 'b.48'],
          'comprehension.3.score'       => ['b.88', 'b.89', 'b.90'],

          'written-language.1.effort'   => ['a.13'],
          'written-language.2.effort'   => ['a.15'],
          'written-language.3.effort'   => ['a.17'],

          'written-language.1.level'    => ['a.12'],
          'written-language.2.level'    => ['a.14'],
          'written-language.3.level'    => ['a.16'],

          'mechanics.1.score'           => ['b.7', 'b.8', 'b.9'],
          'mechanics.2.score'           => ['b.49', 'b.50', 'b.51'],
          'mechanics.3.score'           => ['b.91', 'b.92', 'b.93'],

          'expresses-ideas.1.score'     => ['b.10', 'b.11', 'b.12'],
          'expresses-ideas.2.score'     => ['b.52', 'b.53', 'b.54'],
          'expresses-ideas.3.score'     => ['b.94', 'b.95', 'b.96'],

          'spelling-application.1.score'  => ['b.13', 'b.14', 'b.15'],
          'spelling-application.2.score'  => ['b.55', 'b.56', 'b.57'],
          'spelling-application.3.score'  => ['b.97', 'b.98', 'b.99'],

          'penmanship.1.score'        => ['b.16', 'b.17', 'b.18'],
          'penmanship.2.score'        => ['b.58', 'b.59', 'b.60'],
          'penmanship.3.score'        => ['b.100', 'b.101', 'b.102'],

          'oral-language.1.effort'    => ['a.19'],
          'oral-language.2.effort'    => ['a.21'],
          'oral-language.3.effort'    => ['a.23'],

          'oral-language.1.level'     => ['a.18'],
          'oral-language.2.level'     => ['a.20'],
          'oral-language.3.level'     => ['a.22'],

          'listening.1.score'         => ['b.19','b.20','b.21'],
          'listening.2.score'         => ['b.61','b.62','b.63'],
          'listening.3.score'         => ['b.103','b.104','b.105'],

          'speaking.1.score'         => ['b.22','b.23','b.24'],
          'speaking.2.score'         => ['b.64','b.65','b.66'],
          'speaking.3.score'         => ['b.106','b.107','b.108'],

          'mathematics.1.effort'    => ['a.25'],
          'mathematics.2.effort'    => ['a.27'],
          'mathematics.3.effort'    => ['a.29'],

          'mathematics.1.level'     => ['a.24'],
          'mathematics.2.level'     => ['a.26'],
          'mathematics.3.level'     => ['a.28'],

          'computation.1.score'     => ['b.25','b.26','b.27'],
          'computation.2.score'     => ['b.67','b.68','b.69'],
          'computation.3.score'     => ['b.109','b.110','b.111'],

          'problem-solving-application.1.score' => ['b.28','b.29','b.30'],
          'problem-solving-application.2.score' => ['b.70','b.71','b.72'],
          'problem-solving-application.3.score' => ['b.112','b.113','b.114'],

          'mathematical-communication.1.score'  => ['b.31','b.32','b.33'],
          'mathematical-communication.2.score'  => ['b.73','b.74','b.75'],
          'mathematical-communication.3.score'  => ['b.115','b.116','b.117'],

          'technology-tools.1.score'  => ['b.34','b.35','b.36'],
          'technology-tools.2.score'  => ['b.76','b.77','b.78'],
          'technology-tools.3.score'  => ['b.118','b.119','b.120'],

          'history-soc-science.1.score' => ['b.37','b.38','b.39'],
          'history-soc-science.2.score' => ['b.79','b.80','b.81'],
          'history-soc-science.3.score' => ['b.121','b.122','b.123'],

          'history-soc-science.1.effort'  => ['a.30'],
          'history-soc-science.2.effort'  => ['a.31'],
          'history-soc-science.3.effort'  => ['a.32'],

          'science-health.1.score' => ['b.40','b.41','b.42'],
          'science-health.2.score' => ['b.82','b.83','b.84'],
          'science-health.3.score' => ['b.124','b.125','b.126'],

          'science-health.1.effort' => ['a.33'],
          'science-health.2.effort' => ['a.34'],
          'science-health.3.effort' => ['a.35'],

          'physical-education.1.effort'  => ['a.36'],
          'physical-education.2.effort'  => ['a.37'],
          'physical-education.3.effort'  => ['a.38'],

          'music.1.effort'  => ['a.39'],
          'music.2.effort'  => ['a.40'],
          'music.3.effort'  => ['a.41'],

          'art.1.effort'    => ['a.42'],
          'art.2.effort'    => ['a.43'],
          'art.3.effort'    => ['a.44'],

          'listens-and-follows-instructions.1.effort' => ['a.45'],
          'listens-and-follows-instructions.2.effort' => ['a.46'],
          'listens-and-follows-instructions.3.effort' => ['a.47'],

          'stays-on-task.1.effort' => ['a.48'],
          'stays-on-task.2.effort' => ['a.49'],
          'stays-on-task.3.effort' => ['a.50'],

          'completes-work-accurately.1.effort' => ['a.51'],
          'completes-work-accurately.2.effort' => ['a.52'],
          'completes-work-accurately.3.effort' => ['a.53'],

          'completes-class-work-on-time.1.effort' => ['a.54'],
          'completes-class-work-on-time.2.effort' => ['a.55'],
          'completes-class-work-on-time.3.effort' => ['a.56'],

          'completes-homework-on-time.1.effort' => ['a.57'],
          'completes-homework-on-time.2.effort' => ['a.58'],
          'completes-homework-on-time.3.effort' => ['a.59'],

          'uses-materials-correctly.1.effort' => ['a.60'],
          'uses-materials-correctly.2.effort' => ['a.61'],
          'uses-materials-correctly.3.effort' => ['a.62'],

          'completes-work-neatly.1.effort' => ['a.63'],
          'completes-work-neatly.2.effort' => ['a.64'],
          'completes-work-neatly.3.effort' => ['a.65'],

          'participates-in-small-group-activities.1.effort' => ['a.66'],
          'participates-in-small-group-activities.2.effort' => ['a.67'],
          'participates-in-small-group-activities.3.effort' => ['a.68'],

          'contributes-to-classroom-activities.1.effort' => ['a.69'],
          'contributes-to-classroom-activities.2.effort' => ['a.70'],
          'contributes-to-classroom-activities.3.effort' => ['a.71'],

          'exercises-self-control.1.effort' => ['a.72'],
          'exercises-self-control.2.effort' => ['a.73'],
          'exercises-self-control.3.effort' => ['a.74'],

          'respects-authority.1.effort' => ['a.75'],
          'respects-authority.2.effort' => ['a.76'],
          'respects-authority.3.effort' => ['a.77'],

          'respects-others-rights-property.1.effort' => ['a.78'],
          'respects-others-rights-property.2.effort' => ['a.79'],
          'respects-others-rights-property.3.effort' => ['a.80'],

          'observes-rules.1.effort' => ['a.81'],
          'observes-rules.2.effort' => ['a.82'],
          'observes-rules.3.effort' => ['a.83'],

          'cooperates-with-others.1.effort' => ['a.84'],
          'cooperates-with-others.2.effort' => ['a.85'],
          'cooperates-with-others.3.effort' => ['a.86'],

          'accepts-responsibility.1.effort' => ['a.87'],
          'accepts-responsibility.2.effort' => ['a.88'],
          'accepts-responsibility.3.effort' => ['a.89']

        }
      end

      def value_map
        primary_card_map
      end

      def desired_fields
        value_map.values.flatten.sort
      end

      def attendance_map
        {
          'a.92' => 'absences.1',
          'a.93' => 'absences.2',
          'a.94' => 'absences.3',

          'a.95' => 'tardies.1',
          'a.96' => 'tardies.2',
          'a.97' => 'tardies.3'
        }
      end
    end

  end
end
