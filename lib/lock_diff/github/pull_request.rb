module LockDiff
  module Github
    # wrapper of github PullRequest
    class PullRequest
      def initialize(pull_request)
        @pr = pull_request
      end

      def base_ref
        @pr.base.ref
      end

      def head_ref
        @pr.head.ref
      end

      def number
        @pr.number
      end

      def repository
        @pr.base.repo.full_name
      end

      def find_content_path(file_name)
        Github.client.pull_request_content_path(repository, number, file_name)
      end

      def add_comment(comment)
        Github.client.add_comment(repository, number, comment)
      end

      def base_file(path)
        Github.client.file(repository, path: path, ref: @pr.base.sha)
      end

      def head_file(path)
        Github.client.file(repository, path: path, ref: @pr.head.sha)
      end
    end
  end
end
