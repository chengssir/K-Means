//MARK: K-means

import Foundation
let K = 3
let nums:[(Double, Double)] = [
    (8.0, 12.0),
    (6.0, 15.0),
    (19.0, 1.0),
    (8.0, 13.0),
    (15.0, 19.0),
    (11.0, 12.0),
    (6.0, 13.0),
    (18.0, 12.0),
    (6.0, 8.0),
    (13.0, 19.0)]

var classification = [[(Double, Double)]]()

// 计算两点的距离
func distanceo(_ current:(Double, Double) , other: (Double, Double)) -> Double {
  let result = pow(current.0 - other.0, 2.0) + pow(current.1 - other.1, 2.0) // (x-x1)^2 + (y-y1)^2
  return sqrt(result)
}

//计算距离哪个中心点近
func nearestCenter(_ x: (Double, Double), centers: [(Double, Double)]) -> Int {
    var nearestDist : Double = .greatestFiniteMagnitude //取最大值 用来标记比他小的值
    var minIndex = 0
    //遍历数据
    for (idx, center) in centers.enumerated() {
        let dist = distanceo(x, other: center) //计算数据距离
        //获取最小值
        if dist < nearestDist {
            minIndex = idx
            nearestDist = dist
        }
    }
    return minIndex
}

//计算新的中心点
func newCenter(_ classTem: [[(Double, Double)]]) -> [(Double, Double)] {
    return classTem.map { list -> (Double, Double) in
        var center: (Double, Double) = (0,0)
        for point in list {
            center.0 += point.0
            center.1 += point.1
        }
        center.0 /= Double(list.count)
        center.1 /=  Double(list.count)
        return center
    }
}

//
func calculateCenters(_ points: [(Double, Double)],k: Int) {
    var centers : [(Double, Double)] = [] +  points.prefix(k)
    var centerMoveDist = 0.0

    repeat {
        var classTem: [[(Double, Double)]] = .init(repeating: [], count: k)
        for p in points {
            let classIndex = nearestCenter(p, centers: centers)
            classTem[classIndex].append(p)
        }
        let newCenters = newCenter(classTem)
        centerMoveDist = 0.0
        for idx in 0..<k {
            //新老中心点对比 得出距离
            centerMoveDist += distanceo(centers[idx], other: newCenters[idx])
        }
        centers = newCenters
        classification = classTem

    } while centerMoveDist > 0

    for (index,model) in classification.enumerated() {
        print("第\(index+1)类:\(model)")
    }

}
calculateCenters(nums, k: K)

