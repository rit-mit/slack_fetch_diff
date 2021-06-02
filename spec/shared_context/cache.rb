shared_context 'cache' do
  let(:cache) { double }

  before do
    allow(cache).to receive(:get).and_return(nil)
    allow(cache).to receive(:set).and_return(true)
  end
end
