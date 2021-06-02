shared_context 'client' do
  # NOTE: VCRを使うのでdummyのtoknenを設定しておく
  let(:token) { 'dummy' }
  let(:client) { ::Slack::Web::Client.new(token: token) }
end
