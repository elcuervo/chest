MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end
end

module MiniTest::Spec::SharedExamples
  def shared_examples_for(desc, &block)
    MiniTest::Spec.shared_examples[desc] = block
  end

  def it_behaves_like(desc)
    self.instance_eval do
      MiniTest::Spec.shared_examples[desc].call
    end
  end
end

Object.class_eval { include(MiniTest::Spec::SharedExamples) }

shared_examples_for "A DataStore" do
  describe "Common Actions" do
    before do
      StorableClass ||= Class.new do
        include Chest::Model

        attr_accessor :id, :name
      end

      StorableRepository ||= Class.new do
        include Chest::Repository

        collection StorableClass
        attributes :name
      end

      @model = StorableClass.new(name: "John")
      StorableRepository.save(@model)
    end

    after do
      StorableRepository.reset
    end

    it "should be able to find a model" do
      found_model = StorableRepository.find(@model.id)
      found_with_alias = StorableRepository[@model.id]

      assert_equal @model, found_model
      assert_equal found_with_alias, found_model
    end

    it "should list all the models" do
      models = StorableRepository.find_all

      assert_equal 1, models.size
      assert models.first.is_a?(StorableClass)
    end

    it "should delete a given model" do
      models = StorableRepository.find_all

      StorableRepository.delete(models.first.id)

      assert_equal 0, StorableRepository.find_all.size
    end
  end
end
