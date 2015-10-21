module Ischool
  module FormMaps

    module KinderCard
      def kinder_card_map
        {
          'reading.1.effort'          => 'a.7',
          'reading.2.effort'          => 'a.9',
          'reading.3.effort'          => 'a.11',

          'reading.1.level'           => 'a.6',
          'reading.2.level'           => 'a.8',
          'reading.3.level'           => 'a.10',

          'phonics.1.score'           => ['b.1', 'b.2', 'b.3'],
          'phonics.2.score'           => ['b.37', 'b.38', 'b.39'],
          'phonics.3.score'           => ['b.73', 'b.74', 'b.75'],

          'sight-vocabulary.1.score'  => ['b.4', 'b.5', 'b.6'],
          'sight-vocabulary.2.score'  => ['b.40', 'b.41', 'b.42'],
          'sight-vocabulary.3.score'  => ['b.76', 'b.77', 'b.78'],

          'comprehension.1.score'     => ['b.7', 'b.8', 'b.9'],
          'comprehension.2.score'     => ['b.43', 'b.44', 'b.45'],
          'comprehension.3.score'     => ['b.79', 'b.80', 'b.81'],

          'written-language.1.effort' => 'a.13',
          'written-language.2.effort' => 'a.15',
          'written-language.3.effort' => 'a.17',

          'written-language.1.level'  => 'a.12',
          'written-language.2.level'  => 'a.14',
          'written-language.3.level'  => 'a.16',

          'expresses-ideas.1.score'   => ['b.10', 'b.11', 'b.12'],
          'expresses-ideas.2.score'   => ['b.46', 'b.47', 'b.48'],
          'expresses-ideas.3.score'   => ['b.82', 'b.83', 'b.84'],

          'penmanship.1.score'        => ['b.13', 'b.14', 'b.15'],
          'penmanship.2.score'        => ['b.49', 'b.50', 'b.51'],
          'penmanship.3.score'        => ['b.85', 'b.86', 'b.87'],

          'oral-language.1.effort'    => ['a.19'],
          'oral-language.2.effort'    => ['a.21'],
          'oral-language.3.effort'    => ['a.23'],

          'oral-language.1.level'     => ['a.18'],
          'oral-language.2.level'     => ['a.20'],
          'oral-language.3.level'     => ['a.22'],

          'listening.1.score'         => ['b.16','b.17','b.18'],
          'listening.2.score'         => ['b.52','b.53','b.54'],
          'listening.3.score'         => ['b.85','b.86','b.87'],

          'speaking.1.score'          => ['b.19','b.20','b.21'],
          'speaking.2.score'          => ['b.55','b.56','b.57'],
          'speaking.3.score'          => ['b.91','b.92','b.93'],

          'mathematics.1.effort'      => ['a.25'],
          'mathematics.2.effort'      => ['a.27'],
          'mathematics.3.effort'      => ['a.29'],

          'mathematics.1.level'     => ['a.24'],
          'mathematics.2.level'     => ['a.26'],
          'mathematics.3.level'     => ['a.28'],

          'computation.1.score'     => ['b.22','b.23','b.24'],
          'computation.2.score'     => ['b.58','b.59','b.60'],
          'computation.3.score'     => ['b.94','b.95','b.96'],

          'problem-solving-application.1.score' => ['b.25','b.26','b.27'],
          'problem-solving-application.2.score' => ['b.61','b.62','b.63'],
          'problem-solving-application.3.score' => ['b.97','b.98','b.99'],

          'mathematical-communication.1.score'  => ['b.28','b.29','b.30'],
          'mathematical-communication.2.score'  => ['b.64','b.65','b.66'],
          'mathematical-communication.3.score'  => ['b.100','b.101','b.102'],

          'technology-tools.1.level'    => ['a.30'],
          'technology-tools.2.level'    => ['a.32'],
          'technology-tools.3.level'    => ['a.34'],

          'technology-tools.1.effort'   => ['a.31'],
          'technology-tools.2.effort'   => ['a.33'],
          'technology-tools.3.effort'   => ['a.35'],

          'physical-education.1.level'  => ['a.36'],
          'physical-education.2.level'  => ['a.38'],
          'physical-education.3.level'  => ['a.40'],

          'physical-education.1.effort' => ['a.37'],
          'physical-education.2.effort' => ['a.39'],
          'physical-education.3.effort' => ['a.41'],

          'large-motor-skills.1.score'  => ['b.31', 'b.32', 'b.33'],
          'large-motor-skills.2.score'  => ['b.67', 'b.68', 'b.69'],
          'large-motor-skills.3.score'  => ['b.103', 'b.104', 'b.105'],

          'small-motor-skills.1.score'  => ['b.34', 'b.35', 'b.36'],
          'small-motor-skills.2.score'  => ['b.70', 'b.71', 'b.72'],
          'small-motor-skills.3.score'  => ['b.106', 'b.107', 'b.108'],

          'history-soc-science.1.effort' => ['a.42'],
          'history-soc-science.2.effort' => ['a.43'],
          'history-soc-science.3.effort' => ['a.44'],

          'science-health.1.effort' => ['a.45'],
          'science-health.2.effort' => ['a.46'],
          'science-health.3.effort' => ['a.47'],

          'music.1.effort'  => ['a.48'],
          'music.2.effort'  => ['a.49'],
          'music.3.effort'  => ['a.50'],

          'art.1.effort'    => ['a.51'],
          'art.2.effort'    => ['a.52'],
          'art.3.effort'    => ['a.53'],

          'listens-and-follows-instructions.1.effort' => ['a.54'],
          'listens-and-follows-instructions.2.effort' => ['a.55'],
          'listens-and-follows-instructions.3.effort' => ['a.56'],

          'stays-on-task.1.effort' => ['a.57'],
          'stays-on-task.2.effort' => ['a.58'],
          'stays-on-task.3.effort' => ['a.59'],

          'completes-work-accurately.1.effort' => ['a.60'],
          'completes-work-accurately.2.effort' => ['a.61'],
          'completes-work-accurately.3.effort' => ['a.62'],

          'completes-class-work-on-time.1.effort' => ['a.63'],
          'completes-class-work-on-time.2.effort' => ['a.64'],
          'completes-class-work-on-time.3.effort' => ['a.65'],

          'completes-homework-on-time.1.effort' => ['a.66'],
          'completes-homework-on-time.2.effort' => ['a.67'],
          'completes-homework-on-time.3.effort' => ['a.68'],

          'uses-materials-correctly.1.effort' => ['a.69'],
          'uses-materials-correctly.2.effort' => ['a.70'],
          'uses-materials-correctly.3.effort' => ['a.71'],

          'completes-work-neatly.1.effort' => ['a.72'],
          'completes-work-neatly.2.effort' => ['a.73'],
          'completes-work-neatly.3.effort' => ['a.74'],

          'participates-in-classroom-activities.1.effort' => ['a.75'],
          'participates-in-classroom-activities.2.effort' => ['a.76'],
          'participates-in-classroom-activities.3.effort' => ['a.77'],

          'exercises-self-control.1.effort' => ['a.78'],
          'exercises-self-control.2.effort' => ['a.79'],
          'exercises-self-control.3.effort' => ['a.80'],

          'respects-authority.1.effort' => ['a.81'],
          'respects-authority.2.effort' => ['a.82'],
          'respects-authority.3.effort' => ['a.83'],

          'respects-others-rights-property.1.effort' => ['a.84'],
          'respects-others-rights-property.2.effort' => ['a.85'],
          'respects-others-rights-property.3.effort' => ['a.86'],

          'observes-rules.1.effort' => ['a.87'],
          'observes-rules.2.effort' => ['a.88'],
          'observes-rules.3.effort' => ['a.89'],

          'cooperates-with-others.1.effort' => ['a.90'],
          'cooperates-with-others.2.effort' => ['a.91'],
          'cooperates-with-others.3.effort' => ['a.92'],

          'accepts-responsibility.1.effort' => ['a.93'],
          'accepts-responsibility.2.effort' => ['a.94'],
          'accepts-responsibility.3.effort' => ['a.95']

        }
      end

      def value_map
        kinder_card_map
      end

      def desired_fields
        value_map.values.flatten.sort
      end

      def attendance_map
        {
          'a.98'  => 'absences.1',
          'a.99'  => 'absences.2',
          'a.100' => 'absences.3',

          'a.101' => 'tardies.1',
          'a.102' => 'tardies.2',
          'a.103' => 'tardies.3'
        }
      end
    end

  end
end
