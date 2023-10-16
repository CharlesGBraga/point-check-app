# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Point, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[id marking marking_type approved user_id deleted_at ].each do |column|
      it { expect(model).to include(column) }
    end
  end

  describe '.validation' do
    %w[marking marking_type].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe '.associations' do
    it { is_expected.to belong_to(:user) }
  end
end


# @skill_rates = SkillRateQuery.by_evaluated(rates_by_evaluated)
      # @skill_rates = []
      # rates_by_evaluated.map do |rate|
      #   @skill_rates << { skill_group_id: rate.skill_group_id, skill_group_name: rate.skill_group.name, skill_group_average: 3.3, 
      #                     skills: [{ name: rate.skill.name, evaluated_average: 3.33, position_average: 2.2, rates:[{ evaluator: "Beltrano Alves", rate: 1 },
      #                     {evaluator: "Fulano da Silva", rate: 2 },{ evaluator: "Ciclano de Souza", rate: 3 }]}] }
      # end

      # rates_by_evaluated = @solicitation.rates.by_evaluated(params[:evaluated_id])

# update skill_groups set name = 'skill_group_1' where id = 20;
# update skill_groups set name = 'skill_group_2' where id = 21;
# update skill_groups set name = 'skill_group_3' where id = 22;
# update skill_groups set name = 'skill_group_4' where id = 23;
# update skill_groups set name = 'skill_group_5' where id = 24;
# update skill_groups set name = 'skill_group_6' where id = 25;
# update skill_groups set name = 'skill_group_7' where id = 26;
# update skill_groups set name = 'skill_group_8' where id = 27;
# update skill_groups set name = 'skill_group_9' where id = 28;
# update skill_groups set name = 'skill_group_10' where id = 29;
# update skill_groups set name = 'skill_group_11' where id = 30;
# update skill_groups set name = 'skill_group_12' where id = 31;
# update skill_groups set name = 'skill_group_13' where id = 32;
# update skill_groups set name = 'skill_group_14' where id = 33;
# update skill_groups set name = 'skill_group_15' where id = 34;
# update skill_groups set name = 'skill_group_16' where id = 35;
# update skill_groups set name = 'skill_group_17' where id = 36;
# update skill_groups set name = 'skill_group_18' where id = 37;
# update skill_groups set name = 'skill_group_19' where id = 38;
# update skill_groups set name = 'skill_group_20' where id = 39;
# update skill_groups set name = 'skill_group_21' where id = 40;
# update skill_groups set name = 'skill_group_22' where id = 41;
# update skill_groups set name = 'skill_group_23' where id = 42;
# update skill_groups set name = 'skill_group_24' where id = 43;
# update skill_groups set name = 'skill_group_25' where id = 44;
# update skill_groups set name = 'skill_group_26' where id = 45;
# update skill_groups set name = 'skill_group_27' where id = 46;
# update skill_groups set name = 'skill_group_28' where id = 47;
# update skill_groups set name = 'skill_group_29' where id = 48;
# update skill_groups set name = 'skill_group_30' where id = 49;
# update skill_groups set name = 'skill_group_31' where id = 50;
# update skill_groups set name = 'skill_group_32' where id = 51;
# update skill_groups set name = 'skill_group_33' where id = 52;
# update skill_groups set name = 'skill_group_34' where id = 53;
# update skill_groups set name = 'skill_group_35' where id = 54;
# update skill_groups set name = 'skill_group_36' where id = 55;
# update skill_groups set name = 'skill_group_37' where id = 56;
# update skill_groups set name = 'skill_group_38' where id = 57;
# update skill_groups set name = 'skill_group_39' where id = 58;
# update skill_groups set name = 'skill_group_40' where id = 59;
# update skill_groups set name = 'skill_group_41' where id = 60;
# update skill_groups set name = 'skill_group_42' where id = 61;

