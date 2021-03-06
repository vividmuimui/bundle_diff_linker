module LockDiff
  module Gem
    class LockfileComparator
      def initialize(old_lockfile:, new_lockfile:)
        @old_lockfile = old_lockfile
        @new_lockfile = new_lockfile
      end

      def call
        old_specs_by_name = Spec.parse(@old_lockfile).map { |spec| [spec.name, spec] }.to_h
        new_specs_by_name = Spec.parse(@new_lockfile).map { |spec| [spec.name, spec] }.to_h
        names = (old_specs_by_name.keys + new_specs_by_name.keys).uniq

        names.map { |name|
          DiffInfo.new(
            old_package: (old_specs_by_name[name] || NullSpec.new(name)).to_package,
            new_package: (new_specs_by_name[name] || NullSpec.new(name)).to_package
          )
        }.select(&:changed?)
      end
    end
  end
end
