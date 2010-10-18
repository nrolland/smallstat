require 'basicstat'

describe Array, "#median" do
  a = [[1,2,3,4,5], [1,2,2,3,4,5], [1,2,2,3,4,5, 5,5]]
  it "should return good results" do
    a[0].median.should == 3
  end
  it "should return good results"do
    a[1].median.should be_close(2.66, 0.01)
  end
  it "should return good results"do
    p a[2].median
    a[2].median.should == 3.5
  end
   it "should return good results" do
     a[2].cut(0.5).should == [0, 0, 0, 1]
  end
end